import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';

class SmartCartWidget extends StatefulWidget {
  const SmartCartWidget({super.key, required this.id, required this.type, required this.outOfStock, this.onDoubleTap});

  final int id;
  final CartItemType type;
  final bool outOfStock;
  final Function? onDoubleTap;

  @override
  State<SmartCartWidget> createState() => _SmartCartWidgetState();
}

class _SmartCartWidgetState extends State<SmartCartWidget> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final quantity = ValueNotifier<int>(0);
  late StreamSubscription<dynamic> cartListener;
  late StreamSubscription<dynamic> loadingListener;
  late final CartBus cartBus;

  @override
  void initState() {
    super.initState();
    cartBus = di<CartBus>();

    // Initialize animation
    controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: 1, end: 1.25).animate(controller);

    // Set initial quantity
    WidgetsBinding.instance.addPostFrameCallback((_) {
      quantity.value = _getQuantity();
    });

    // Listen to cart events
    cartListener = cartBus.getStream<GetCartEvents>().listen((_) {
      if (mounted) {
        quantity.value = _getQuantity();
      }
    });

    // Listen to loading events to update quantity when loading completes
    loadingListener = cartBus.getStream<FastItemActionsLoading>().listen((event) {
      if (mounted && (event.prodId == widget.id)) {
        // Update quantity when loading completes
        quantity.value = _getQuantity();
      }
    });
  }

  @override
  void dispose() {
    cartListener.cancel();
    loadingListener.cancel();
    controller.dispose();
    quantity.dispose();
    super.dispose();
  }

  /// Get current quantity from cart
  int _getQuantity() {
    return cartBus.cartItems.firstWhereOrNull((item) => item.prod.id == widget.id && item.type == widget.type)?.quantity ?? 0;
  }

  /// Get cart item entity
  CartItemEntity? _getCartItem() {
    return cartBus.cartItems.firstWhereOrNull((item) => item.prod.id == widget.id && item.type == widget.type);
  }

  /// Pulse animation for cart actions
  Future<void> _pulseAnimate() async {
    controller.forward().then((_) async {
      if (!mounted) return;
      controller.reverse();
      controller.forward();
      controller.reverse();
    });
  }

  /// Add item to cart with quantity 1
  void _addToCart() {
    final req = CartableItemRequest(cartItemId: null, id: widget.id, quantity: 1, note: null, options: {}, type: widget.type);
    cartBus.addToCart(req);
    _pulseAnimate();
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
      _pulseAnimate();
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
      _pulseAnimate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.outOfStock
        ? Center(
            child: SizedBox(
              height: 30,
              child: Text(L10n.tr().outOfStock, style: context.style12400.copyWith(color: Co.red)),
            ),
          )
        : ValueListenableBuilder<int>(
            valueListenable: quantity,
            builder: (context, qty, child) {
              return StreamBuilder(
                stream: cartBus.getStream<FastItemActionsLoading>(),
                builder: (context, snapshot) {
                  // if (snapshot.hasData && snapshot.data!.prodId == widget.id) {
                  //   return _buildLoadingIndicator();
                  // }

                  if (qty > 0) {
                    return _buildQuantityControls(qty);
                  } else {
                    return _buildAddButton();
                  }
                },
              );
            },
          );
  }

  /// Build add button (when item is NOT in cart)
  Widget _buildAddButton() {
    return ScaleTransition(
      scale: animation,
      child: DoubledDecoratedWidget(
        innerDecoration: BoxDecoration(
          borderRadius: AppConst.defaultBorderRadius,
          gradient: Grad().linearGradient,
          border: GradientBoxBorder(gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white])),
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
            shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
          ),
          icon: const Icon(Icons.add, color: Co.secondary, size: 22),
        ),
      ),
    );
  }

  /// Build quantity controls (when item IS in cart)
  Widget _buildQuantityControls(int qty) {
    return ScaleTransition(
      scale: animation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DoubledDecoratedWidget(
            innerDecoration: BoxDecoration(
              borderRadius: AppConst.defaultBorderRadius,
              gradient: Grad().linearGradient,
              border: GradientBoxBorder(gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white])),
            ),
            child: InkWell(
              onTap: () {
                SystemSound.play(SystemSoundType.click);
                _decrement();
              },
              onDoubleTap: () {
                SystemSound.play(SystemSoundType.click);
                widget.onDoubleTap?.call();
              },
              borderRadius: AppConst.defaultBorderRadius,
              customBorder: const CircleBorder(),
              // style: IconButton.styleFrom(
              //   padding: const EdgeInsets.all(5),
              //   elevation: 0,
              //   minimumSize: Size.zero,
              //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: AppConst.defaultBorderRadius,
              //   ),
              // ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.remove, color: Co.secondary, size: 20),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 40),
            child: Text(
              '$qty',
              style: context.style16500.copyWith(color: Co.secondary, fontWeight: TStyle.bold),
              textAlign: TextAlign.center,
            ),
          ),
          DoubledDecoratedWidget(
            innerDecoration: BoxDecoration(
              borderRadius: AppConst.defaultBorderRadius,
              gradient: Grad().linearGradient,
              border: GradientBoxBorder(gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white])),
            ),
            child: InkWell(
              onTap: () {
                SystemSound.play(SystemSoundType.click);
                _increment();
              },
              onDoubleTap: () {
                SystemSound.play(SystemSoundType.click);
                widget.onDoubleTap?.call();
              },
              borderRadius: AppConst.defaultBorderRadius,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.add, color: Co.secondary, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
