import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';

class CartBus extends AppBus {
  final CartRepo _repo;
  CartBus(this._repo);

  int? addressId;
  double subTotal = 0.0;
  double deliveryFee = 0.0;
  double serviceFee = 0.0;
  double discount = 0.0;
  double total = 0.0;
  List<CartVendorEntity> vendors = [];

  Future<void> loadCart() async {
    fire(GetCartLoading());
    final response = await _repo.getCart();
    switch (response) {
      case Ok<CartResponse> res:
        addressId = res.value.addressId;
        subTotal = res.value.subTotal;
        deliveryFee = res.value.deliveryFee;
        serviceFee = res.value.serviceFee;
        discount = res.value.discount;
        total = res.value.total;
        vendors = res.value.vendors;
        fire(GetCartLoaded(data: res.value));
        break;
      case Err err:
        fire(GetCartError(err.error.message));
    }
  }

  Future<void> addToCart(CartableItemRequest req) async {
    fire(AddCartItemLoading());
    final response = await _repo.addToCartItem(req);
    switch (response) {
      case Ok<String> res:
        fire(AddCartItemLoaded(message: res.value));
        break;
      case Err err:
        fire(AddCartItemError(message: err.error.message));
    }
  }

  void clearCart() {
    addressId = null;
    subTotal = 0.0;
    deliveryFee = 0.0;
    serviceFee = 0.0;
    discount = 0.0;
    total = 0.0;
    vendors.clear();
    fire(
      GetCartLoaded(
        data: CartResponse(
          subTotal: subTotal,
          deliveryFee: deliveryFee,
          serviceFee: serviceFee,
          discount: discount,
          total: total,
          vendors: vendors,
        ),
      ),
    );
  }
}
