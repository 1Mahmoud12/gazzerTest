import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/ordered_with_increment.dart';

class OrderedWithCard extends StatelessWidget {
  const OrderedWithCard({super.key, required this.product, required this.type});
  final OrderedWithEntity product;
  final CartItemType type;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: CustomPaint(
            painter: ProductShapePaint(),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CircleGradientBorderedImage(
                            image: product.image,
                            shadow: const BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2)),
                            showBorder: false,
                          ),
                        ),
                        FavoriteWidget(size: 24, fovorable: product),
                      ],
                    ),
                    const VerticalSpacing(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(product.name, style: TStyle.primaryBold(15))),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Co.secondary, size: 16),
                                  Text(
                                    product.rate.toStringAsFixed(1),
                                    style: TStyle.mainwSemi(12).copyWith(color: Co.secondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            Helpers.getProperPrice(product.price),
                            style: TStyle.blackSemi(12).copyWith(shadows: AppDec.blackTextShadow),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: StreamBuilder(
                    stream: di<CartBus>().getStream<FastItemEvents>(),
                    builder: (context, snapshot) {
                      final cartItem = snapshot.data?.items.firstWhereOrNull((e) => e.prod.id == product.id);
                      final isLoading = snapshot.data?.prodId == cartItem?.cartId;
                      print("Isloading item: $isLoading");
                      if (cartItem != null) {
                        return OrderedWithIncrement(
                          isAdding: isLoading && snapshot.data?.state.isIncreasing == true,
                          isRemoving: isLoading && snapshot.data?.state.isDecreasing == true,
                          onChanged: (isAdding) {
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
                        );
                      } else {
                        return AddIcon(
                          isLoading: snapshot.data?.prodId == product.id && snapshot.data?.state.isAdding == true,
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            di<CartBus>().addToCart(
                              CartableItemRequest(
                                id: product.id,
                                quantity: 1,
                                options: {},
                                type: type,
                                note: null,
                                cartItemId: null,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
