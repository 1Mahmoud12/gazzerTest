import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';

abstract class CartRepo extends BaseApiRepo {
  CartRepo(super.crashlyticsRepo);

  Future<Result<CartResponse>> getCart();
  Future<Result<CartResponse>> addToCartItem(CartableItemRequest req);
  Future<Result<CartResponse>> updateCartItem(CartableItemRequest req);
  Future<Result<CartResponse>> removeCartItem(int id);
  Future<Result<CartResponse>> updateItemQuantity(int id, int qnty);
  Future<Result<CartResponse>> updateItemNote(int id, String? note);
  Future<Result<CartResponse>> updateCartAddress(int addressId);

  Future<Result<List<String>>> getAvailableSlots();
}
