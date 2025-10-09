import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';

class SmartCartWidget extends StatelessWidget {
  const SmartCartWidget({
    super.key,
    required this.id,
    required this.type,
    required this.outOfStock,
    required this.cartBus,
  });

  final int id;
  final CartItemType type;
  final bool outOfStock;
  final CartBus cartBus;

  /// Check if item is in cart
  bool _isInCart() {
    return cartBus.cartIds[type]?.contains(id) ?? false;
  }

  /// Get current quantity from cart
  int _getQuantity() {
    return cartBus.cartItems.firstWhereOrNull((item) => item.prod.id == id)?.quantity ?? 0;
  }

  /// Get cart item entity
  CartItemEntity? _getCartItem() {
    return cartBus.cartItems.firstWhereOrNull(
      (item) => item.prod.id == id,
    );
  }

  /// Add item to cart with quantity 1
  void _addToCart() {
    final req = CartableItemRequest(
      cartItemId: null,
      id: id,
      quantity: 1,
      note: null,
      options: {},
      type: type,
    );
    cartBus.addToCart(req);
  }

  /// Increment quantity
  void _increment() {
    final cartItem = _getCartItem();
    if (cartItem != null) {
      cartBus.updateItemQuantity(
        cartItem.cartId,
        cartItem.quantity + 1,
        true, // isAdding
      );
    }
  }

  /// Decrement quantity or remove if quantity would be 0
  void _decrement() {
    final cartItem = _getCartItem();
    if (cartItem != null) {
      if (cartItem.quantity > 1) {
        cartBus.updateItemQuantity(
          cartItem.cartId,
          cartItem.quantity - 1,
          false, // isAdding
        );
      } else {
        // Remove from cart if quantity would be 0
        cartBus.removeItemFromCart(cartItem.cartId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return outOfStock
        ? Center(
            child: SizedBox(
              height: 30,
              child: Text(
                L10n.tr().outOfStock,
                style: TStyle.errorSemi(12),
              ),
            ),
          )
        : StreamBuilder(
            stream: cartBus.getStream<GetCartEvents>(),
            builder: (context, snapshot) {
              // Show quantity controls if in cart, otherwise show add button
              if (_isInCart()) {
                return _buildQuantityControlsWithLoading();
              } else {
                return _buildAddButtonWithLoading();
              }
            },
          );
  }

  /// Build add button with loading check
  Widget _buildAddButtonWithLoading() {
    return StreamBuilder(
      stream: cartBus.getStream<FastItemActionsLoading>(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.prodId == id) {
          return _buildLoadingIndicator();
        }
        return _buildAddButton();
      },
    );
  }

  /// Build quantity controls with loading check
  Widget _buildQuantityControlsWithLoading() {
    return StreamBuilder(
      stream: cartBus.getStream<FastItemActionsLoading>(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active && id == snapshot.data!.prodId) {
          return _buildLoadingIndicator();
        }
        return _buildQuantityControls();
      },
    );
  }

  /// Build add button (when item is NOT in cart)
  Widget _buildAddButton() {
    return DoubledDecoratedWidget(
      innerDecoration: BoxDecoration(
        borderRadius: AppConst.defaultBorderRadius,
        gradient: Grad().linearGradient,
        border: GradientBoxBorder(
          gradient: Grad().shadowGrad().copyWith(
            colors: [Co.white.withAlpha(0), Co.white],
          ),
        ),
      ),
      child: IconButton(
        onPressed: () {
          SystemSound.play(SystemSoundType.click);
          _addToCart();
        },
        style: IconButton.styleFrom(
          padding: const EdgeInsets.all(5),
          elevation: 0,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: AppConst.defaultBorderRadius,
          ),
        ),
        icon: const Icon(Icons.add, color: Co.secondary, size: 22),
      ),
    );
  }

  /// Build quantity controls (when item IS in cart)
  Widget _buildQuantityControls() {
    final quantity = _getQuantity();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DoubledDecoratedWidget(
          innerDecoration: BoxDecoration(
            borderRadius: AppConst.defaultBorderRadius,
            gradient: Grad().linearGradient,
            border: GradientBoxBorder(
              gradient: Grad().shadowGrad().copyWith(
                colors: [Co.white.withAlpha(0), Co.white],
              ),
            ),
          ),
          child: IconButton(
            onPressed: () {
              SystemSound.play(SystemSoundType.click);
              _increment();
            },
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(5),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: AppConst.defaultBorderRadius,
              ),
            ),
            icon: const Icon(Icons.add, color: Co.secondary, size: 22),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: Text(
            "$quantity",
            style: TStyle.secondaryBold(16),
            textAlign: TextAlign.center,
          ),
        ),
        DoubledDecoratedWidget(
          innerDecoration: BoxDecoration(
            borderRadius: AppConst.defaultBorderRadius,
            gradient: Grad().linearGradient,
            border: GradientBoxBorder(
              gradient: Grad().shadowGrad().copyWith(
                colors: [Co.white.withAlpha(0), Co.white],
              ),
            ),
          ),
          child: IconButton(
            onPressed: () {
              SystemSound.play(SystemSoundType.click);
              _decrement();
            },
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(5),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: AppConst.defaultBorderRadius,
              ),
            ),
            icon: const Icon(Icons.remove, color: Co.secondary, size: 20),
          ),
        ),
      ],
    );
  }

  /// Build loading indicator
  Widget _buildLoadingIndicator() {
    return const SizedBox(
      height: 32,
      width: 32,
      child: AdaptiveProgressIndicator(),
    );
  }
}
