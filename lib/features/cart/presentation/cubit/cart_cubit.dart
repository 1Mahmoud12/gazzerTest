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
    addressId = address?.id;
    if (addressId != null) emit(UpdateCartAddressLoaded(address: address));
  }

  final List<CartVendorEntity> _vendors = [];
  CartSummaryModel _summary = Fakers.cartSummary;
  int? addressId;

  void _updateCartWithNEwResponse(CartResponse res) {
    _bus.cartResponseToValues(res);
    _vendors.clear();
    _vendors.addAll(res.vendors);
    _summary = res.summary;
    addressId = res.addressId;
    final address = Session().addresses.firstWhereOrNull((e) => e.id == addressId);
    if (address != null) emit(UpdateCartAddressLoaded(address: address));
    emit(UpdateVendorsLoaded(vendors: _vendors));
    emit(UpdateSummaryLoaded(summary: _summary));
  }

  Future<void> loadCart() async {
    emit(UpdateVendorsLoading());
    emit(UpdateSummaryLoading());
    final response = await _repo.getCart();
    switch (response) {
      case Ok<CartResponse> res:
        _updateCartWithNEwResponse(res.value);
        break;
      case Err err:
        emit(UpdateVendorsError(message: err.error.message));
        emit(UpdateSummaryError(message: err.error.message));
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
    emit(UpdateCartAddressLoading());
    final response = await _repo.updateCartAddress(address.id);
    switch (response) {
      case Ok<CartResponse> res:
        emit(UpdateCartAddressLoaded(address: address));
        _updateCartWithNEwResponse(res.value);
        break;
      case Err err:
        emit(UpdateCartAddressError(message: err.error.message, address: address));
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
    addressId = address.id;
    emit(UpdateCartAddressLoaded(address: address));
  }

  void onReloadCartBus() {
    loadCart();
  }
}
