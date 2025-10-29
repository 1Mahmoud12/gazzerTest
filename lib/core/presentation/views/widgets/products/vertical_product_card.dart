import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({
    super.key,
    required this.product,
    required this.canAdd,
    this.fontFactor = 1.0,
    this.onTap,
  });
  final GenericItemEntity product;
  final bool canAdd;
  final double fontFactor;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: InkWell(
            borderRadius: AppConst.defaultBorderRadius,
            onTap: () {
              SystemSound.play(SystemSoundType.click);
              if (onTap != null) {
                onTap?.call();
              } else {
                // Navigate based on item type
                if (product is PlateEntity) {
                  PlateDetailsRoute(id: product.id).push(context);
                } else if (product is ProductEntity) {
                  ProductDetailsRoute(productId: product.id).push(context);
                }
              }
            },

            child: CustomPaint(
              painter: ProductShapePaint(),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: constraints.maxWidth * 0.6,
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
                          FavoriteWidget(
                            size: 32 * fontFactor,
                            fovorable: product,
                          ),
                        ],
                      ),
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
                                    style: TStyle.primaryBold(13 * fontFactor),
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
                                        12 * fontFactor,
                                      ).copyWith(color: Co.secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (product.store != null)
                              InkWell(
                                onTap: () {
                                  if (product.store?.id == null) {
                                    return;
                                  }

                                  if (product.store!.type == VendorType.restaurant.value) {
                                    RestaurantDetailsRoute(
                                      id: product.store!.id,
                                    ).push(context);
                                  } else if (product.store!.type == VendorType.grocery.value) {
                                    StoreDetailsRoute(
                                      storeId: product.store!.id,
                                    ).push(context);
                                  } else {
                                    StoreDetailsRoute(
                                      storeId: product.store!.id,
                                    ).push(context);
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircleGradientBorderedImage(
                                        image: product.store?.image ?? '',
                                        shadow: const BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                        ),
                                        showBorder: false,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        product.store?.name ?? '',
                                        style: TStyle.mainwSemi(
                                          13 * fontFactor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (canAdd)
                              Text(
                                Helpers.getProperPrice(product.price),
                                style: TStyle.blackSemi(
                                  12 * fontFactor,
                                ).copyWith(shadows: AppDec.blackTextShadow),
                              )
                            else
                              SizedBox(
                                width: constraints.maxWidth * 0.55,
                                child: Text(
                                  product.description,
                                  style: TStyle.mainwSemi(12 * fontFactor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: Grad().radialGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: Grad().linearGradient,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: canAdd
                              ? InkWell(
                                  onTap: () {
                                    SystemSound.play(SystemSoundType.click);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.add,
                                      color: Co.second2,
                                      size: 24 * fontFactor,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "${product.offer?.discount}${product.offer?.discountType == DiscountType.percentage ? "%" : ""}\n${(product.offer?.isExpired() ?? false) ? "On" : "OFF"}",
                                    style: TStyle.mainwBold(
                                      11 * fontFactor,
                                    ).copyWith(color: Co.secondary),
                                  ),
                                ),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 8),
                      if (Session().client != null && !(key?.toString().contains('store') ?? false))
                        CartToIncrementIcon(
                          isHorizonal: true,
                          product: product,
                          iconSize: 25,
                          isDarkContainer: true,
                        ),
                      // Expanded(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       // SmartCartWidget(
                      //       //   id: product.productId ?? product.id,
                      //       //   type: product is PlateEntity
                      //       //       ? CartItemType.plate
                      //       //       : product is ProductEntity
                      //       //       ? CartItemType.product
                      //       //       : CartItemType.restaurantItem,
                      //       //   outOfStock: product.outOfStock,
                      //       //   onDoubleTap: () {
                      //       //     SystemSound.play(SystemSoundType.click);
                      //       //     if (onTap != null) {
                      //       //       onTap?.call();
                      //       //     } else {
                      //       //       // Navigate based on item type
                      //       //       if (product is PlateEntity) {
                      //       //         PlateDetailsRoute(id: product.id).push(context);
                      //       //       } else if (product is ProductEntity) {
                      //       //         ProductDetailsRoute(productId: product.id).push(context);
                      //       //       }
                      //       //     }
                      //       //   },
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
