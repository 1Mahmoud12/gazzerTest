import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/rating_widget.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({super.key, required this.product});
  final GenericItemEntity product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 250,
        child: InkWell(
          borderRadius: AppConst.defaultBorderRadius,
          onTap: () {
            if (product is PlateEntity) {
              PlateDetailsRoute(id: product.id, $extra: findCartItem(context.read<CartCubit>(), product)).push(context);
            } else if (product is ProductEntity) {
              ProductDetailsRoute(productId: product.id, $extra: findCartItem(context.read<CartCubit>(), product)).push(context);
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 350,
                margin: const EdgeInsets.only(top: 110.5),
                padding: AppConst.defaultPadding,
                decoration: BoxDecoration(
                  image: const DecorationImage(image: AssetImage(Assets.customShapeSuggestIc), fit: BoxFit.fill),

                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name, style: TStyle.robotBlackMedium().copyWith(fontWeight: FontWeight.w700)),
                              const VerticalSpacing(8),
                              if (product.description.isNotEmpty) ...[
                                Text(
                                  product.description,
                                  style: TStyle.robotBlackSmall(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                                const VerticalSpacing(8),
                              ],
                              if (product.store != null)
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
                                        child: Text(
                                          product.store?.name ?? '',
                                          style: TStyle.robotBlackMedium(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const VerticalSpacing(8),
                              AppRatingWidget(product.rate.toStringAsFixed(1), itemSize: 16),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(color: Co.purple, shape: BoxShape.circle),
                          child: Text(
                            '${Helpers.getProperPrice(product.price, showCurrency: false)}\n${L10n.tr().egp}',
                            style: TStyle.robotBlackMedium().copyWith(color: Co.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FavoriteWidget(size: 40, fovorable: product, padding: 0),
                        CartToIncrementIcon(product: product, isHorizonal: true, iconSize: 18, isDarkContainer: true, newUi: true),
                      ],
                    ),
                    const VerticalSpacing(20),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [ClipOval(child: CustomNetworkImage(product.image, fit: BoxFit.cover, width: 123, height: 123))],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
