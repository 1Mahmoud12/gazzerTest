import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/models/cart_summary_model.dart';

class CartCubit extends Cubit<CartStates> {
  @override
  void emit(CartStates state) {
    if (isClosed) return;
    super.emit(state);
  }

  final CartRepo _repo;
  final CartBus _bus;
  CartCubit(this._repo, this._bus) : super(CartInitial()) {
    final address = Session().addresses.firstWhereOrNull((e) => e.isDefault);
    if (address != null) {
      emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: validateCart()));
    }
  }

  final List<CartVendorEntity> _vendors = [];
  CartSummaryModel _summary = Fakers.cartSummary;
  AddressEntity? address;
  void _updateCartWithNEwResponse(CartResponse res) {
    _bus.cartResponseToValues(res);
    _vendors.clear();
    _vendors.addAll(res.vendors);
    _summary = res.summary;
    if (res.addressId != null) address = Session().addresses.firstWhereOrNull((e) => e.id == res.addressId);
    emit(FullCartLoaded(vendors: _vendors, summary: _summary, address: address, isCartValid: validateCart()));
  }

  Future<void> loadCart() async {
    emit(FullCartLoading());
    final response = await _repo.getCart();
    switch (response) {
      case Ok<CartResponse> res:
        _updateCartWithNEwResponse(res.value);
        break;
      case Err err:
        emit(FullCartError(message: err.error.message));
        break;
    }
  }

  Future<void> updateItemQuantity(int id, int qnty, bool isAdding) async {
    if (qnty < 1) return;
    emit(UpdateItemLoading(cartId: id, isAdding: isAdding, isRemoving: !isAdding));
    final response = await _repo.updateItemQuantity(id, qnty);
    switch (response) {
      case Ok<CartResponse> res:
        emit(UpdateItemSuccess(cartId: id, isAdding: isAdding, isRemoving: !isAdding));
        _updateCartWithNEwResponse(res.value);
        break;
      case Err err:
        emit(UpdateItemError(message: err.error.message, cartId: id, isAdding: isAdding, isRemoving: !isAdding));
        break;
    }
  }

  Future<void> updateItemNote(int cartId, String note) async {
    emit(UpdateItemLoading(cartId: cartId, isEditNote: true));
    final response = await _repo.updateItemNote(cartId, note);
    switch (response) {
      case Ok<CartResponse> res:
        emit(UpdateItemSuccess(cartId: cartId));
        _updateCartWithNEwResponse(res.value);
        break;
      case Err err:
        emit(UpdateItemError(message: err.error.message, cartId: cartId));
        break;
    }
  }

  Future<void> removeItemFromCart(int id) async {
    emit(UpdateItemLoading(cartId: id, isDeleting: true));
    final response = await _repo.removeCartItem(id);
    switch (response) {
      case Ok<CartResponse> res:
        emit(UpdateItemSuccess(cartId: id));
        _updateCartWithNEwResponse(res.value);
        break;
      case Err err:
        emit(UpdateItemError(message: err.error.message, cartId: id));
        break;
    }
  }

  Future<void> updateCartAddress(AddressEntity address) async {
    emit(FullCartLoading());
    final response = await _repo.updateCartAddress(address.id);
    switch (response) {
      case Ok<CartResponse> res:
        _updateCartWithNEwResponse(res.value);
        break;
      case Err err:
        emit(FullCartError(message: err.error.message));
        break;
    }
  }

  final _timeSlots = <String>[];
  Future<void> getTimeSlots() async {
    emit(TimeSlotsLoading());
    final response = await _repo.getAvailableSlots();
    switch (response) {
      case Ok<List<String>> res:
        _timeSlots.clear();
        _timeSlots.addAll(res.value);
        emit(TimeSlotsLoaded(timeSlots: _timeSlots, selectedTime: selectedTime));
        break;
      case Err err:
        emit(TimeSlotsError(message: err.error.message));
    }
  }

  String? selectedTime;
  void selectTimeSlot(String? time) {
    selectedTime = time;
    emit(TimeSlotsLoaded(timeSlots: _timeSlots, selectedTime: selectedTime));
  }

  void selectAddress(AddressEntity address) {
    this.address = address;
    emit(FullCartLoaded(vendors: _vendors, summary: _summary, isCartValid: validateCart(), address: address));
  }

  void onReloadCartBus() {
    loadCart();
  }

  bool validateCart() {
    if (address == null) return false;

    /// if total products price less than minimum required, show error
    /// if any vendor not available
    /// if any product is out of stock or not available
    /// if scheduling is active and no timeslot selected
    return true;
  }
}
