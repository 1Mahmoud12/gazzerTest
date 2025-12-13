import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/models/cart_summary_model.dart';
import 'package:gazzer/features/vendors/common/presentation/exceed_bottom_sheet.dart';

/// Manages the shopping cart state and operations.
///
/// This cubit is the single source of truth for cart data across the application.
/// It handles:
/// - Loading cart data from the server
/// - Adding/removing items
/// - Updating item quantities
/// - Managing delivery address
/// - Scheduling delivery time slots
///
/// All cart widgets should depend on this cubit for cart operations.
class CartCubit extends Cubit<CartStates> {
  final CartRepo _repo;
  final CartBus _bus;

  // ==================== Private State ====================

  final List<CartVendorEntity> _vendors = [];
  CartSummaryModel _summary = Fakers.cartSummary;
  AddressEntity? address;
  String? selectedTime;
  final List<String> _timeSlots = [];
  PouchSummary? _pouchSummary;

  // ==================== Debouncing State ====================

  final Map<int, Timer?> _updateTimers = {};
  final Map<int, int> _pendingQuantities = {};
  static const _debounceDuration = Duration(milliseconds: 1000);

  // ==================== Public Getters ====================

  /// Returns an unmodifiable view of all vendors in the cart.
  /// Widgets should use this to access current cart data.
  List<CartVendorEntity> get vendors => List.unmodifiable(_vendors);

  /// Returns the current cart summary (totals, discounts, etc.)
  CartSummaryModel get summary => _summary;

  // ==================== Constructor ====================

  CartCubit(this._repo, this._bus) : super(CartInitial()) {
    _initializeWithDefaultAddress();
  }

  @override
  void emit(CartStates state) {
    if (isClosed) return;
    super.emit(state);
  }

  @override
  Future<void> close() {
    // Cancel all pending timers
    for (final timer in _updateTimers.values) {
      timer?.cancel();
    }
    _updateTimers.clear();
    _pendingQuantities.clear();
    _originalQuantities.clear();
    return super.close();
  }

  // ==================== Initialization ====================

  void _initializeWithDefaultAddress() {
    final defaultAddress = Session().addresses.firstWhereOrNull((address) => address.isDefault);

    if (defaultAddress != null) {
      address = defaultAddress;
      emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart(), pouchSummary: _pouchSummary));
    }
  }

  // ==================== Cart Operations ====================

  /// Loads the cart from the server.
  ///
  /// Called on app startup and when refreshing cart data.
  Future<void> loadCart() async {
    emit(FullCartLoading());

    final response = await _repo.getCart();

    switch (response) {
      case Ok<CartResponse>(:final value):
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        emit(FullCartError(message: error.message));
        break;
    }
  }

  /// Adds a new item to the cart.
  ///
  /// [req] contains the item details, quantity, and any customization options.
  Future<void> addToCart(BuildContext context, CartableItemRequest req) async {
    emit(UpdateItemLoading(cartId: req.id, isAdding: true));

    final response = await _repo.addToCartItem(req);

    switch (response) {
      case Ok<CartResponse>(:final value):
        emit(UpdateItemSuccess(cartId: req.id, isAdding: true));
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        // Check if error is CartError with needs_new_pouch_approval = true
        if (context.mounted && error is CartError && error.needsNewPouchApproval) {
          final confirmed = await warningAlert(
            title: L10n.tr().exceedPouch,
            context: context,
            cancelBtn: L10n.tr().editItems,
            okBtn: L10n.tr().assignAdditionalDelivery,
          );

          if (confirmed == true && context.mounted) {
            await addToCart(context, req.copyWith(exceedPouch: true));
          }
          emit(UpdateItemError(message: error.message, cartId: req.id, isAdding: true, needsNewPouchApproval: true));
        } else if (context.mounted) {
          // Show error message in alert/toast for other errors
          Alerts.showToast(error.message);
          emit(UpdateItemError(message: error.message, cartId: req.id, isAdding: true));
        }

        // Emit FullCartLoaded to clear loading state (no cart changes)
        emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart()));
        break;
    }
  }

  /// Updates the quantity of an existing cart item with debouncing.
  ///
  /// [id] is the cart item ID (not the product ID)
  /// [quantity] is the new quantity
  /// [isAdding] indicates if this is an increment (true) or decrement (false)
  ///
  /// This method implements debouncing: if called multiple times within 500ms,
  /// only the final quantity will be sent to the server.
  void updateItemQuantity(int id, int quantity, bool isAdding, BuildContext context) {
    if (quantity < 1) return;

    // Cancel existing timer for this item
    _updateTimers[id]?.cancel();

    // Store the pending quantity
    _pendingQuantities[id] = quantity;

    // Update the cart item quantity optimistically (without loading state)
    _updateCartItemQuantityOptimistically(id, quantity);

    // Set new timer
    _updateTimers[id] = Timer(_debounceDuration, () {
      final finalQuantity = _pendingQuantities[id];
      if (finalQuantity != null) {
        _executeQuantityUpdate(id, finalQuantity, isAdding, context);
        _pendingQuantities.remove(id);
        _updateTimers.remove(id);
      }
    });
  }

  /// Stores original quantities before optimistic update for rollback on error.
  final Map<int, int> _originalQuantities = {};

  /// Updates cart item quantity optimistically without API call.
  void _updateCartItemQuantityOptimistically(int id, int quantity) {
    // Find the cart item and update its quantity locally
    for (int vendorIndex = 0; vendorIndex < _vendors.length; vendorIndex++) {
      final vendor = _vendors[vendorIndex];
      for (int itemIndex = 0; itemIndex < vendor.items.length; itemIndex++) {
        final item = vendor.items[itemIndex];
        if (item.cartId == id) {
          // Store original quantity for rollback on error
          if (!_originalQuantities.containsKey(id)) {
            _originalQuantities[id] = item.quantity;
          }

          // Create new item with updated quantity
          final updatedItem = item.copyWith(quantity: quantity);

          // Create new vendor with updated item
          final updatedItems = List<CartItemEntity>.from(vendor.items);
          updatedItems[itemIndex] = updatedItem;
          final updatedVendor = CartVendorEntity(id: vendor.id, name: vendor.name, image: vendor.image, type: vendor.type, items: updatedItems);

          // Update the vendor in the list
          _vendors[vendorIndex] = updatedVendor;

          // Emit updated state without loading indicator
          emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart()));
          return;
        }
      }
    }
  }

  /// Reverts the optimistic update by restoring the original quantity.
  void _revertOptimisticUpdate(int id) {
    final originalQuantity = _originalQuantities[id];
    if (originalQuantity == null) {
      // If no original quantity stored, just reload cart from current state
      emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart(), pouchSummary: _pouchSummary));
      return;
    }

    // Find the cart item and revert its quantity
    for (int vendorIndex = 0; vendorIndex < _vendors.length; vendorIndex++) {
      final vendor = _vendors[vendorIndex];
      for (int itemIndex = 0; itemIndex < vendor.items.length; itemIndex++) {
        final item = vendor.items[itemIndex];
        if (item.cartId == id) {
          // Restore original quantity
          final revertedItem = item.copyWith(quantity: originalQuantity);

          // Create new vendor with reverted item
          final revertedItems = List<CartItemEntity>.from(vendor.items);
          revertedItems[itemIndex] = revertedItem;
          final revertedVendor = CartVendorEntity(id: vendor.id, name: vendor.name, image: vendor.image, type: vendor.type, items: revertedItems);

          // Update the vendor in the list
          _vendors[vendorIndex] = revertedVendor;

          // Clear the stored original quantity
          _originalQuantities.remove(id);

          // Emit updated state to clear loading state
          emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart()));
          return;
        }
      }
    }

    // If item not found in cart, just emit current state to clear loading
    emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart()));
  }

  /// Executes the actual API call for quantity update.
  Future<void> _executeQuantityUpdate(int id, int quantity, bool isAdding, BuildContext context, {bool exceedPouch = false}) async {
    // Show loading indicator only when API call starts
    emit(UpdateItemLoading(cartId: id, isAdding: isAdding, isRemoving: !isAdding));

    final response = await _repo.updateItemQuantity(id, quantity, exceedPouch: exceedPouch);

    switch (response) {
      case Ok<CartResponse>(:final value):
        // Clear the original quantity on success
        _originalQuantities.remove(id);

        emit(UpdateItemSuccess(cartId: id, isAdding: isAdding, isRemoving: !isAdding));
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        // Check if error is CartError with needs_new_pouch_approval = true
        if (context.mounted && error is CartError && error.needsNewPouchApproval) {
          final confirmed = await warningAlert(
            title: L10n.tr().exceedPouch,
            context: context,
            cancelBtn: L10n.tr().editItems,
            okBtn: L10n.tr().assignAdditionalDelivery,
          );

          if (confirmed == true) {
            if (context.mounted) {
              _executeQuantityUpdate(id, quantity, isAdding, context, exceedPouch: true);
            }
          }
          emit(UpdateItemError(message: error.message, cartId: id, isAdding: isAdding, needsNewPouchApproval: true, isRemoving: !isAdding));
        } else if (context.mounted) {
          // Check if error is about maximum quantity reached
          final isMaxQuantityError =
              error.message.toLowerCase().contains('maximum quantity') ||
              error.message.toLowerCase().contains('max_quantity') ||
              error.message.toLowerCase().contains('available:');

          // Show error message in alert/toast for other errors
          Alerts.showToast(error.message);
          emit(
            UpdateItemError(message: error.message, cartId: id, isAdding: isAdding, isRemoving: !isAdding, isMaxQuantityReached: isMaxQuantityError),
          );
        }

        // Then revert the optimistic update (emits FullCartLoaded to clear loading)
        _revertOptimisticUpdate(id);
        break;
    }
  }

  /// Updates the special note/instructions for a cart item.
  Future<void> updateItemNote(int cartId, String note) async {
    emit(UpdateItemLoading(cartId: cartId, isEditNote: true));

    final response = await _repo.updateItemNote(cartId, note);

    switch (response) {
      case Ok<CartResponse>(:final value):
        emit(UpdateItemSuccess(cartId: cartId));
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        // Emit error for toast notification
        emit(UpdateItemError(message: error.message, cartId: cartId));

        // Emit FullCartLoaded to clear loading state
        emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart()));
        break;
    }
  }

  /// Removes an item from the cart completely.
  ///
  /// This method cancels any pending quantity updates for the item
  /// and immediately removes it from the cart.
  Future<void> removeItemFromCart(int id) async {
    // Cancel any pending quantity updates for this item
    _updateTimers[id]?.cancel();
    _updateTimers.remove(id);
    _pendingQuantities.remove(id);

    emit(UpdateItemLoading(cartId: id, isDeleting: true));

    final response = await _repo.removeCartItem(id);

    switch (response) {
      case Ok<CartResponse>(:final value):
        emit(UpdateItemSuccess(cartId: id));
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        // Emit error for toast notification
        emit(UpdateItemError(message: error.message, cartId: id));

        // Emit FullCartLoaded to clear loading state (item not removed)
        emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart()));
        break;
    }
  }

  /// Clears all cart data.
  ///
  /// Called on logout or when explicitly clearing the cart.
  void clearCart() {
    _vendors.clear();
    _summary = Fakers.cartSummary;
    address = null;
    selectedTime = null;
    _timeSlots.clear();

    emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: false, pouchSummary: _pouchSummary));
  }

  // ==================== Address Management ====================

  /// Updates the delivery address for the cart.
  Future<void> updateCartAddress(AddressEntity newAddress) async {
    emit(FullCartLoading());

    final response = await _repo.updateCartAddress(newAddress.id);

    switch (response) {
      case Ok<CartResponse>(:final value):
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        emit(FullCartError(message: error.message));
        break;
    }
  }

  /// Selects a delivery address without making an API call.
  ///
  /// Used for local address selection before checkout.
  void selectAddress(AddressEntity newAddress) {
    address = newAddress;
    emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart()));
  }

  // ==================== Time Slot Management ====================

  /// Fetches available delivery time slots from the server.
  Future<void> getTimeSlots() async {
    emit(TimeSlotsLoading());

    final response = await _repo.getAvailableSlots();

    switch (response) {
      case Ok<List<String>>(:final value):
        _timeSlots.clear();
        _timeSlots.addAll(value);
        emit(TimeSlotsLoaded(timeSlots: _timeSlots, selectedTime: selectedTime));
        break;
      case Err(:final error):
        emit(TimeSlotsError(message: error.message));
        break;
    }
  }

  /// Selects a delivery time slot.
  void selectTimeSlot(String? time) {
    selectedTime = time;
    emit(TimeSlotsLoaded(timeSlots: _timeSlots, selectedTime: selectedTime));
  }

  // ==================== Internal Helpers ====================

  /// Updates internal state with new cart data from the server.
  ///
  /// This is the central method that:
  /// 1. Syncs with CartBus for backward compatibility
  /// 2. Updates local state
  /// 3. Resolves the delivery address
  /// 4. Emits the new state
  void _updateCartWithNewResponse(CartResponse response) {
    // Sync with CartBus (for backward compatibility with legacy code)
    _bus.cartResponseToValues(response);

    // Update local state
    _vendors.clear();
    _vendors.addAll(response.vendors);
    _summary = response.summary;
    _pouchSummary = response.pouchSummary;

    // Resolve delivery address
    address = _resolveDeliveryAddress(response.addressId);

    // Emit updated state
    emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: _validateCart(), pouchSummary: _pouchSummary));
  }

  /// Resolves the delivery address from the response or defaults to the user's default address.
  AddressEntity? _resolveDeliveryAddress(int? addressId) {
    final userAddresses = Session().addresses;

    if (addressId != null) {
      return userAddresses.firstWhereOrNull((address) => address.id == addressId);
    }

    return userAddresses.firstWhereOrNull((address) => address.isDefault);
  }

  /// Validates if the cart is ready for checkout.
  ///
  /// TODO: Implement comprehensive validation:
  /// - Minimum order amount per vendor
  /// - Vendor availability (open/closed)
  /// - Product stock availability
  /// - Scheduling time slot selection (if scheduling is enabled)
  bool _validateCart() {
    if (address == null) return false;

    // Additional validation logic can be added here
    return true;
  }

  // ==================== Legacy Support ====================

  /// Triggers a cart reload.
  ///
  /// This method exists for backward compatibility with CartBus-based code.
  /// New code should call [loadCart] directly.
  @Deprecated('Use loadCart() directly instead')
  void onReloadCartBus() {
    loadCart();
  }
}
