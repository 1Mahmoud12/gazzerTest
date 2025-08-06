import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';

class CartRepoImp extends CartRepo {
  final ApiClient _apiclient;
  CartRepoImp(this._apiclient, super.crashlyticsRepo);

  @override
  Future<Result<CartResponse>> getCart() {
    return super.call(
      apiCall: () async => _apiclient.get(endpoint: Endpoints.getCart),
      parser: (response) {
        return CartResponse.fromJson(response.data['data']);
      },
    );
  }

  @override
  Future<Result<String>> addToCartItem(CartableItemRequest req) {
    return super.call(
      apiCall: () async => _apiclient.post(endpoint: Endpoints.addToCart, requestBody: req.toJson()),
      parser: (response) {
        return response.data['message'].toString();
      },
    );
  }

  @override
  Future<Result<String>> removeCartItem(int id) {
    // TODO: implement removeCartItem
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> updateCartItem(CartableItemRequest req) {
    // TODO: implement updateCartItem
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> updateItemNote(int id, String? note) {
    // TODO: implement updateItemNote
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> updateItemQuantity(int id, int qnty) {
    // TODO: implement updateItemQuantity
    throw UnimplementedError();
  }

  @override
  Future<Result<List<String>>> getAvailableSlots(int cartId) {
    // TODO: implement getAvailableSlots
    throw UnimplementedError();
  }
}
