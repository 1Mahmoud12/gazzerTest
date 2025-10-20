import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/models/cart_summary_model.dart';

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

  // ==================== Initialization ====================

  void _initializeWithDefaultAddress() {
    final defaultAddress = Session().addresses.firstWhereOrNull(
      (address) => address.isDefault,
    );

    if (defaultAddress != null) {
      address = defaultAddress;
      emit(
        FullCartLoaded(
          vendors: _vendors,
          summary: _summary,
          address: address,
          isCartValid: _validateCart(),
        ),
      );
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
  Future<void> addToCart(CartableItemRequest req) async {
    emit(UpdateItemLoading(cartId: req.id, isAdding: true));

    final response = await _repo.addToCartItem(req);

    switch (response) {
      case Ok<CartResponse>(:final value):
        emit(UpdateItemSuccess(cartId: req.id, isAdding: true));
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        emit(
          UpdateItemError(
            message: error.message,
            cartId: req.id,
            isAdding: true,
          ),
        );
        break;
    }
  }

  /// Updates the quantity of an existing cart item.
  ///
  /// [id] is the cart item ID (not the product ID)
  /// [quantity] is the new quantity
  /// [isAdding] indicates if this is an increment (true) or decrement (false)
  Future<void> updateItemQuantity(
    int id,
    int quantity,
    bool isAdding,
  ) async {
    if (quantity < 1) return;

    emit(
      UpdateItemLoading(
        cartId: id,
        isAdding: isAdding,
        isRemoving: !isAdding,
      ),
    );

    final response = await _repo.updateItemQuantity(id, quantity);

    switch (response) {
      case Ok<CartResponse>(:final value):
        emit(
          UpdateItemSuccess(
            cartId: id,
            isAdding: isAdding,
            isRemoving: !isAdding,
          ),
        );
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        emit(
          UpdateItemError(
            message: error.message,
            cartId: id,
            isAdding: isAdding,
            isRemoving: !isAdding,
          ),
        );
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
        emit(UpdateItemError(message: error.message, cartId: cartId));
        break;
    }
  }

  /// Removes an item from the cart completely.
  Future<void> removeItemFromCart(int id) async {
    emit(UpdateItemLoading(cartId: id, isDeleting: true));

    final response = await _repo.removeCartItem(id);

    switch (response) {
      case Ok<CartResponse>(:final value):
        emit(UpdateItemSuccess(cartId: id));
        _updateCartWithNewResponse(value);
        break;
      case Err(:final error):
        emit(UpdateItemError(message: error.message, cartId: id));
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

    emit(
      FullCartLoaded(
        vendors: _vendors,
        summary: _summary,
        address: address,
        isCartValid: false,
      ),
    );
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
    emit(
      FullCartLoaded(
        vendors: _vendors,
        summary: _summary,
        address: address,
        isCartValid: _validateCart(),
      ),
    );
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
        emit(
          TimeSlotsLoaded(
            timeSlots: _timeSlots,
            selectedTime: selectedTime,
          ),
        );
        break;
      case Err(:final error):
        emit(TimeSlotsError(message: error.message));
        break;
    }
  }

  /// Selects a delivery time slot.
  void selectTimeSlot(String? time) {
    selectedTime = time;
    emit(
      TimeSlotsLoaded(
        timeSlots: _timeSlots,
        selectedTime: selectedTime,
      ),
    );
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

    // Resolve delivery address
    address = _resolveDeliveryAddress(response.addressId);

    // Emit updated state
    emit(
      FullCartLoaded(
        vendors: _vendors,
        summary: _summary,
        address: address,
        isCartValid: _validateCart(),
      ),
    );
  }

  /// Resolves the delivery address from the response or defaults to the user's default address.
  AddressEntity? _resolveDeliveryAddress(int? addressId) {
    final userAddresses = Session().addresses;

    if (addressId != null) {
      return userAddresses.firstWhereOrNull(
        (address) => address.id == addressId,
      );
    }

    return userAddresses.firstWhereOrNull(
      (address) => address.isDefault,
    );
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
