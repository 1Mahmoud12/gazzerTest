import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';

class CartBus extends AppBus {
  final CartRepo _repo;
  CartBus(this._repo);

  int? _addressId;
  double _subTotal = 0.0;
  double _deliveryFee = 0.0;
  double _serviceFee = 0.0;
  double _discount = 0.0;
  double _total = 0.0;
  final List<CartVendorEntity> _vendors = [];
  final List<String> _timeSlots = [];

  int? get addressId => _addressId;
  List<CartVendorEntity> get vendors => _vendors;

  void _cartResponseToValues(CartResponse response) {
    _addressId = response.addressId;
    _subTotal = response.subTotal;
    _deliveryFee = response.deliveryFee;
    _serviceFee = response.serviceFee;
    _discount = response.discount;
    _total = response.total;
    _vendors.clear();
    _vendors.addAll(response.vendors);
  }

  CartResponse get cartResponse => CartResponse(
    addressId: _addressId,
    subTotal: _subTotal,
    deliveryFee: _deliveryFee,
    serviceFee: _serviceFee,
    discount: _discount,
    total: _total,
    vendors: _vendors,
  );

  Future<void> loadCart() async {
    if (Session().client == null) {
      return Alerts.showToast(L10n.tr().pleaseLoginToUseCart, isInfo: true);
    }
    fire(GetCartLoading());
    final response = await _repo.getCart();
    switch (response) {
      case Ok<CartResponse> res:
        _cartResponseToValues(res.value);
        fire(GetCartLoaded(data: res.value));
        break;
      case Err err:
        fire(GetCartError(err.error.message));
    }
  }

  Future<(bool, String)> addToCart(CartableItemRequest req) async {
    fire(UpdateCartItemsLoading(data: cartResponse, cartId: -1));
    final response = await _repo.addToCartItem(req);
    switch (response) {
      case Ok<CartResponse> res:
        _cartResponseToValues(res.value);
        fire(UpdateCartItemsLoaded(data: res.value, cartId: -1));
        return (true, res.value.message ?? '');
      case Err err:
        fire(UpdateCartItemsError(err.error.message, cartId: -1));
        return (false, err.error.message);
    }
  }

  Future<(bool, String)> updateCart(CartableItemRequest req, int cartId) async {
    fire(UpdateCartItemsLoading(data: cartResponse, cartId: cartId));
    final response = await _repo.updateCartItem(req);
    switch (response) {
      case Ok<CartResponse> res:
        _cartResponseToValues(res.value);
        fire(UpdateCartItemsLoaded(data: res.value, cartId: cartId));
        return (true, res.value.message ?? '');
      case Err err:
        fire(UpdateCartItemsError(err.error.message, cartId: cartId));
        return (false, err.error.message);
    }
  }

  Future<(bool, String)> updateItemQuantity(int id, int qnty) async {
    fire(UpdateCartItemsLoading(data: cartResponse, cartId: id));
    final response = await _repo.updateItemQuantity(id, qnty);
    switch (response) {
      case Ok<CartResponse> res:
        _cartResponseToValues(res.value);
        fire(UpdateCartItemsLoaded(data: res.value, cartId: id));
        return (true, res.value.message ?? '');
      case Err err:
        fire(UpdateCartItemsError(err.error.message, cartId: id));
        return (false, err.error.message);
    }
  }

  Future<(bool, String)> updateItemNote(int id, String note, int cartId) async {
    fire(UpdateCartItemsLoading(data: cartResponse, cartId: cartId));
    final response = await _repo.updateItemNote(id, note);
    switch (response) {
      case Ok<CartResponse> res:
        _cartResponseToValues(res.value);
        fire(UpdateCartItemsLoaded(data: res.value, cartId: cartId));
        return (true, res.value.message ?? '');
      case Err err:
        fire(UpdateCartItemsError(err.error.message, cartId: cartId));
        return (false, err.error.message);
    }
  }

  Future<(bool, String)> removeItemFromCart(int id) async {
    fire(UpdateCartItemsLoading(data: cartResponse, cartId: id));
    final response = await _repo.removeCartItem(id);
    switch (response) {
      case Ok<CartResponse> res:
        _cartResponseToValues(res.value);
        fire(UpdateCartItemsLoaded(data: res.value, cartId: id));
        return (true, res.value.message ?? '');
      case Err err:
        fire(UpdateCartItemsError(err.error.message, cartId: id));
        return (false, err.error.message);
    }
  }

  Future<(bool, String)> updateCartAddress(int id, int cartId) async {
    fire(UpdateCartItemsLoading(data: cartResponse, cartId: cartId));
    final response = await _repo.updateCartAddress(id);
    switch (response) {
      case Ok<CartResponse> res:
        _cartResponseToValues(res.value);
        fire(UpdateCartItemsLoaded(data: res.value, cartId: -1));
        return (true, res.value.message ?? '');
      case Err err:
        fire(UpdateCartItemsError(err.error.message, cartId: cartId));
        return (false, err.error.message);
    }
  }

  Future<List<String>> getTimeSlots(int id) async {
    fire(GetTimeSlotsLoading());
    final response = await _repo.getAvailableSlots();
    switch (response) {
      case Ok<List<String>> res:
        _timeSlots.clear();
        _timeSlots.addAll(res.value);
        fire(GetTimeSlotsLoaded(slots: res.value));
        return res.value;
      case Err err:
        fire(GetTimeSlotsError(err.error.message));
        return [];
    }
  }

  void clearCart() {
    _addressId = null;
    _subTotal = 0.0;
    _deliveryFee = 0.0;
    _serviceFee = 0.0;
    _discount = 0.0;
    _total = 0.0;
    _timeSlots.clear();
    vendors.clear();
    fire(
      GetCartLoaded(
        data: CartResponse(
          subTotal: _subTotal,
          deliveryFee: _deliveryFee,
          serviceFee: _serviceFee,
          discount: _discount,
          total: _total,
          vendors: vendors,
        ),
      ),
    );
  }
}
