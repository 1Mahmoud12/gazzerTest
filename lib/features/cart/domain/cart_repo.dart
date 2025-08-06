import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';

abstract class CartRepo extends BaseApiRepo {
  CartRepo(super.crashlyticsRepo);

  Future<Result<CartResponse>> getCart();
  Future<Result<String>> addToCartItem(CartableItemRequest req);
  Future<Result<String>> updateCartItem(CartableItemRequest req);
  Future<Result<String>> removeCartItem(int id);
  Future<Result<String>> updateItemQuantity(int id, int qnty);
  Future<Result<String>> updateItemNote(int id, String? note);

  Future<Result<List<String>>> getAvailableSlots(int cartId);
}
