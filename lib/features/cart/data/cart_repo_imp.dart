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
  Future<Result<CartResponse>> addToCartItem(CartableItemRequest req) {
    return super.call(
      apiCall: () async => _apiclient.post(endpoint: Endpoints.addToCart, requestBody: req.toJson()),
      parser: (response) {
        return CartResponse.fromJson(response.data['data'], msg: response.data['message']);
      },
    );
  }

  @override
  Future<Result<CartResponse>> removeCartItem(int id) {
    return super.call(
      apiCall: () async => _apiclient.post(endpoint: Endpoints.removeFromCart, requestBody: {'cart_item_id': id}),
      parser: (response) {
        return CartResponse.fromJson(response.data['data'], msg: response.data['message']);
      },
    );
  }

  @override
  Future<Result<CartResponse>> updateCartItem(CartableItemRequest req) {
    return super.call(
      apiCall: () async => _apiclient.post(endpoint: Endpoints.updateCartItem, requestBody: req.toJson()),
      parser: (response) {
        return CartResponse.fromJson(response.data['data'], msg: response.data['message']);
      },
    );
  }

  @override
  Future<Result<CartResponse>> updateItemNote(int id, String? note) {
    return super.call(
      apiCall: () async => _apiclient.post(
        endpoint: Endpoints.updatecartItemNote(id),
        requestBody: {'notes': note},
      ),
      parser: (response) {
        return CartResponse.fromJson(response.data['data'], msg: response.data['message']);
      },
    );
  }

  @override
  Future<Result<CartResponse>> updateItemQuantity(int id, int qnty, {bool exceedPouch = false}) {
    return super.call(
      apiCall: () async => _apiclient.post(
        endpoint: Endpoints.changeItemQnty,
        requestBody: {'cart_item_id': id, 'quantity': qnty, 'add_new_pouch_approval': exceedPouch},
      ),
      parser: (response) {
        return CartResponse.fromJson(response.data['data'], msg: response.data['message']);
      },
    );
  }

  @override
  Future<Result<CartResponse>> updateCartAddress(int addressId) {
    return super.call(
      apiCall: () async => _apiclient.post(
        endpoint: Endpoints.updateCartAddress,
        requestBody: {'client_address_id': addressId},
      ),
      parser: (response) {
        return CartResponse.fromJson(response.data['data'], msg: response.data['message']);
      },
    );
  }

  @override
  Future<Result<List<String>>> getAvailableSlots() {
    return super.call(
      apiCall: () async => _apiclient.get(endpoint: Endpoints.getAvailableSlots),
      parser: (response) {
        if (response.data is! Map) return [];
        final data = response.data['data'] as List<dynamic>;
        return data.isNotEmpty ? data.map((e) => e.toString()).toList() : [];
      },
    );
  }
}
