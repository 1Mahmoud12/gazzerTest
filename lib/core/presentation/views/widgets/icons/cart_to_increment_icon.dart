import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/switching_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/global_increment_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';

class CartToIncrementIcon extends StatelessWidget {
  const CartToIncrementIcon({
    super.key,
    required this.product,
    required this.isHorizonal,
    required this.iconSize,
    required this.isDarkContainer,
    this.isCartIcon = true,
  });
  final GenericItemEntity product;
  final bool isHorizonal;
  final double iconSize;
  final bool isDarkContainer;
  final bool isCartIcon;
  @override
  Widget build(BuildContext context) {
    void navigateToDetails(CartItemEntity? cartItem) {
      switch (product) {
        case PlateEntity():
          PlateDetailsRoute(id: product.id, $extra: cartItem).push(context);
          break;
        case ProductEntity():
          ProductDetailsRoute(productId: product.id, $extra: cartItem).push(context);
          break;
        case OrderedWithEntity():
          break;
      }
    }

    CartItemType productType() => switch (product) {
      PlateEntity() => CartItemType.plate,
      ProductEntity() => CartItemType.product,
      OrderedWithEntity() => CartItemType.restaurantItem,
    };

    //
    // TODO: in home items can be added to cart without checking the related vendor is open or not.
    // TODO: It needs to be verified with the business owner.
    return StreamBuilder(
      stream: di<CartBus>().getStream<FastItemEvents>(),
      initialData: FastItemActionsLoaded(items: di<CartBus>().cartItems, prodId: product.id),
      builder: (context, snapshot) {
        final cartItem = snapshot.data?.items.firstWhereOrNull((e) => e.prod.id == product.id);

        final isChangingQnty = snapshot.data?.prodId == cartItem?.cartId;

        if (cartItem != null) {
          return GlobalIncrementWidget(
            iconSize: iconSize,
            isDarkContainer: isDarkContainer,
            isAdding: isChangingQnty && snapshot.data?.state.isIncreasing == true,
            isRemoving: isChangingQnty && snapshot.data?.state.isDecreasing == true,
            onChanged: (isAdding) {
              if (product.hasOptions) return navigateToDetails(cartItem);
              if (isAdding) {
                di<CartBus>().updateItemQuantity(cartItem.cartId, cartItem.quantity + 1, true);
              } else {
                if (cartItem.quantity == 1) {
                  di<CartBus>().removeItemFromCart(cartItem.cartId);
                } else {
                  di<CartBus>().updateItemQuantity(cartItem.cartId, cartItem.quantity - 1, false);
                }
              }
            },
            initVal: cartItem.quantity,
            isHorizonal: isHorizonal,
          );
        } else {
          final isAdding = snapshot.data?.prodId == product.id && snapshot.data?.state.isAdding == true;
          return !isCartIcon
              ? AddIcon(
                  isLoading: isAdding,
                  onTap: () {
                    if (product.hasOptions) return navigateToDetails(cartItem);
                    di<CartBus>().addToCart(
                      CartableItemRequest(
                        id: product.id,
                        quantity: 1,
                        options: {},
                        type: productType(),
                        note: null,
                        cartItemId: null,
                      ),
                    );
                  },
                )
              : SwitchingDecoratedwidget(
                  isDarkContainer: isDarkContainer,
                  borderRadius: BorderRadius.circular(100),
                  child: isAdding
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: AdaptiveProgressIndicator(size: 20, color: isDarkContainer ? Co.secondary : Co.purple),
                        )
                      : IconButton(
                          onPressed: () {
                            if (product.hasOptions) return navigateToDetails(cartItem);
                            di<CartBus>().addToCart(
                              CartableItemRequest(
                                id: product.id,
                                quantity: 1,
                                options: {},
                                type: productType(),
                                note: null,
                                cartItemId: null,
                              ),
                            );
                          },
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: Size.zero,
                          ),
                          icon: SvgPicture.asset(
                            Assets.assetsSvgCart,
                            height: 20,
                            width: 20,
                            colorFilter: ColorFilter.mode(isDarkContainer ? Co.secondary : Co.purple, BlendMode.srcIn),
                          ),
                        ),
                );
        }
      },
    );
  }
}
