import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({super.key, required this.product, required this.canAdd, this.fontFactor = 1.0, this.onTap, this.ignorePointer = false});
  final GenericItemEntity product;
  final bool canAdd;
  final bool ignorePointer;
  final double fontFactor;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    if (product.store == null) return const SizedBox.shrink();
    //    logger.d(product.offer!.discount.toString());
    return IgnorePointer(
      ignoring: ignorePointer,
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          // log(findCartItem(context.read<CartCubit>(), product).toString());
          if (onTap != null) {
            onTap?.call();
          } else {
            // Navigate based on item type
            if (product is PlateEntity) {
              PlateDetailsRoute(id: product.id /*, $extra: findCartItem(context.read<CartCubit>(), product)*/).push(context);
            } else if (product is ProductEntity) {
              ProductDetailsRoute(productId: product.id /*, $extra: findCartItem(context.read<CartCubit>(), product)*/).push(context);
            }
          }
        },

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Co.lightGrey),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadiusGeometry.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    child: CustomNetworkImage(product.image, height: 130, width: double.infinity, fit: BoxFit.fill),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (product.offer == null)
                          const SizedBox()
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                            decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "${product.offer?.discount}${product.offer?.discountType == DiscountType.percentage ? "%" : ""}",
                              style: TStyle.robotBlackMedium(),
                            ),
                          ),
                        FavoriteWidget(size: 40, fovorable: product, padding: 0),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: TStyle.robotBlackMedium().copyWith(fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(width: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.starRateIc, width: 20, height: 20),
                            const HorizontalSpacing(4),
                            Text(product.rate.toStringAsFixed(1), style: TStyle.robotBlackRegular()),
                          ],
                        ),
                      ],
                    ),
                    // if (product.description != '') ...[
                    //   const VerticalSpacing(10),
                    //   Text(
                    //     product.description,
                    //     style: TStyle.robotBlackSmall(),
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis,
                    //     textAlign: TextAlign.start,
                    //   ),
                    // ],
                    if (product.store != null) ...[
                      const VerticalSpacing(10),
                      InkWell(
                        onTap: () {
                          if (product.store?.id == null) {
                            return;
                          }

                          if (product.store!.type == VendorType.restaurant.value) {
                            RestaurantDetailsRoute(id: product.store!.id).push(context);
                          } else if (product.store!.type == VendorType.grocery.value) {
                            StoreDetailsRoute(storeId: product.store!.id).push(context);
                          } else if (product.store!.type == VendorType.pharmacy.value) {
                            PharmacyStoreScreenRoute(id: product.store!.id).push(context);
                          }
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.restaurantNameIc),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(product.store?.name ?? '', style: TStyle.robotBlackMedium(), overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const VerticalSpacing(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(Helpers.getProperPrice(product.price), style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
                              ),
                              FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  Helpers.getProperPrice(product.priceBeforeDiscount!),
                                  style: TStyle.robotBlackMedium().copyWith(decoration: TextDecoration.lineThrough, color: Co.greyText),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),
                        if (!(key?.toString().contains('store') ?? false))
                          CartToIncrementIcon(isHorizonal: true, product: product, iconSize: 25, isDarkContainer: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
