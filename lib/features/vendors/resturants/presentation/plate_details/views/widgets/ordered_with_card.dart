import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/global_increment_widget.dart';

class OrderedWithCard extends StatelessWidget {
  const OrderedWithCard({
    super.key,
    required this.product,
    required this.type,
    required this.isDisabled,
  });
  final OrderedWithEntity product;
  final CartItemType type;
  final bool isDisabled;

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
                            shadow: const BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
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
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: TStyle.primaryBold(15),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Co.secondary,
                                    size: 16,
                                  ),
                                  Text(
                                    product.rate.toStringAsFixed(1),
                                    style: TStyle.mainwSemi(
                                      12,
                                    ).copyWith(color: Co.secondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            Helpers.getProperPrice(product.price),
                            style: TStyle.blackSemi(
                              12,
                            ).copyWith(shadows: AppDec.blackTextShadow),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: BlocBuilder<CartCubit, CartStates>(
                    builder: (context, state) {
                      final cubit = context.read<CartCubit>();
                      final cartItem = cubit.vendors.expand((vendor) => vendor.items).firstWhereOrNull((e) => e.prod.id == product.id);

                      if (cartItem != null) {
                        final updateState = state is UpdateItemStates ? state : null;
                        final isUpdating = updateState != null && updateState.cartId == cartItem.cartId;

                        return AbsorbPointer(
                          absorbing: isDisabled,
                          child: GlobalIncrementWidget(
                            isDarkContainer: true,
                            isHorizonal: true,
                            isAdding: isUpdating && updateState.isAdding,
                            isRemoving: isUpdating && updateState.isRemoving,
                            onChanged: (isAdding) {
                              if (isAdding) {
                                cubit.updateItemQuantity(
                                  cartItem.cartId,
                                  cartItem.quantity + 1,
                                  true,
                                );
                              } else {
                                if (cartItem.quantity == 1) {
                                  cubit.removeItemFromCart(cartItem.cartId);
                                } else {
                                  cubit.updateItemQuantity(
                                    cartItem.cartId,
                                    cartItem.quantity - 1,
                                    false,
                                  );
                                }
                              }
                            },
                            initVal: cartItem.quantity,
                          ),
                        );
                      } else {
                        final updateState = state is UpdateItemStates ? state : null;
                        final isAdding = updateState != null && updateState.cartId == product.id && updateState.isAdding;

                        return AbsorbPointer(
                          absorbing: isDisabled,
                          child: AddIcon(
                            isLoading: isAdding,
                            onTap: () {
                              SystemSound.play(SystemSoundType.click);
                              cubit.addToCart(
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
                          ),
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
