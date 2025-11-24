import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';
import 'package:gazzer/features/cart/presentation/bus/item_fast_actions_state.dart';

class CartBus extends AppBus {
  final CartRepo _repo;
  CartBus(this._repo);

  final List<CartVendorEntity> _vendors = [];
  List<CartVendorEntity> get vendors => _vendors;
  final Map<CartItemType, Set<int>> _cartIds = {};
  Map<CartItemType, Set<int>> get cartIds => _cartIds;
  final List<CartItemEntity> _cartItems = [];
  List<CartItemEntity> get cartItems => _cartItems;
  Future<Result<CartResponse>> loadCart() async {
    fire(GetCartLoading());
    final response = await _repo.getCart();
    switch (response) {
      case Ok<CartResponse> res:
        _vendors.clear();
        _vendors.addAll(res.value.vendors);
        _cartITems();
        cartResponseToValues(res.value);
      case Err err:
        fire(GetCartError(err.error.message));
    }
    return response;
  }

  Future<void> addToCart(CartableItemRequest req) async {
    fire(
      FastItemActionsLoading(
        items: _cartITems(),
        prodId: req.id,
        state: const ItemFastActionState(isAdding: true),
      ),
    );
    final response = await _repo.addToCartItem(req);
    switch (response) {
      case Ok<CartResponse> res:
        cartResponseToValues(res.value);
        fire(
          FastItemActionsLoaded(
            items: _cartITems(),
            prodId: req.id,
          ),
        );
        return;
      case Err err:
        // Alerts.showToast("${err.error.message}.");

        fire(
          FastItemActionsError(
            err.error.message,
            prodId: req.id,
            items: _cartITems(),
          ),
        );
        return;
    }
  }

  List<CartItemEntity> _cartITems() {
    _cartIds.clear();
    _cartItems.clear();
    _cartItems.addAll(
      _vendors.map((e) => e.items).expand((element) => element).toList(),
    );
    for (final item in _cartItems) {
      _cartIds[item.type] ??= {};
      _cartIds[item.type]!.add(item.prod.id);
    }
    return _cartItems;
  }

  Future<void> updateItemQuantity(int id, int qnty, bool isAdding) async {
    fire(
      FastItemActionsLoading(
        items: _cartITems(),
        prodId: id,

        state: ItemFastActionState(
          isIncreasing: isAdding,
          isDecreasing: !isAdding,
        ),
      ),
    );
    final response = await _repo.updateItemQuantity(id, qnty);
    switch (response) {
      case Ok<CartResponse> res:
        cartResponseToValues(res.value);
        fire(
          FastItemActionsLoaded(
            items: _cartITems(),
            prodId: id,
          ),
        );
        return;
      case Err err:
        // Alerts.showToast("${err.error.message}.");
        fire(
          FastItemActionsError(
            err.error.message,
            prodId: id,

            items: _cartITems(),
          ),
        );
        return;
    }
  }

  Future<void> removeItemFromCart(int id) async {
    fire(
      FastItemActionsLoading(
        items: _cartITems(),
        prodId: id,

        state: const ItemFastActionState(isDecreasing: true),
      ),
    );
    final response = await _repo.removeCartItem(id);
    switch (response) {
      case Ok<CartResponse> res:
        cartResponseToValues(res.value);
        fire(
          FastItemActionsLoaded(
            items: _cartITems(),
            prodId: id,
          ),
        );
        return;
      case Err err:
        // Alerts.showToast("${err.error.message}.");
        fire(
          FastItemActionsError(
            err.error.message,
            prodId: id,
            items: _cartITems(),
          ),
        );
        return;
    }
  }

  void cartResponseToValues(CartResponse response) {
    _vendors.clear();
    _vendors.addAll(response.vendors);
    _cartITems(); // Update internal cart items and IDs
    fire(GetCartLoaded(data: response));
  }

  void clearCart() {
    vendors.clear();
    fire(
      GetCartLoaded(
        data: CartResponse(summary: Fakers.cartSummary, vendors: vendors, pouchSummary: Fakers.pouchSummary, pouches: Fakers.pouches),
      ),
    );
  }
}
