import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart' show AppConst;
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart' show TStyle;
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';

import 'circle_gradient_image.dart';

class VerticalRotatedImgCard extends StatelessWidget {
  const VerticalRotatedImgCard({super.key, required this.prod, required this.onTap});
  final GenericItemEntity prod;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Co.lightGrey),
        borderRadius: AppConst.defaultBorderRadius,
      ),
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: onTap,
        child: Row(
          children: [
            Stack(
              children: [
                CustomNetworkImage(prod.image, width: 100, height: 100, borderRaduis: AppConst.defaultRadius),
                FavoriteWidget(fovorable: prod),
              ],
            ),
            const HorizontalSpacing(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(prod.name, style: TStyle.robotBlackMedium(), overflow: TextOverflow.ellipsis),
                      ),
                      const HorizontalSpacing(8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const VectorGraphicsWidget(Assets.starRateIc),
                          const HorizontalSpacing(4),
                          Text(prod.rate.toStringAsFixed(1), style: TStyle.robotBlackSmall()),
                          const HorizontalSpacing(2),
                          Text('(+${prod.reviewCount})', style: TStyle.robotBlackSmall().copyWith(color: Co.darkGrey)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            if (prod.store?.id == null) {
                              return;
                            }

                            if (prod.store!.type == VendorType.restaurant.value) {
                              RestaurantDetailsRoute(id: prod.store!.id).push(context);
                            } else if (prod.store!.type == VendorType.grocery.value) {
                              StoreDetailsRoute(storeId: prod.store?.id ?? -1).push(context);
                            } else {
                              StoreDetailsRoute(storeId: prod.store?.id ?? -1).push(context);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: CircleGradientBorderedImage(
                                  image: prod.store?.image ?? '',
                                  shadow: const BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2)),
                                  showBorder: false,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: FittedBox(
                                  alignment: AlignmentDirectional.centerStart,
                                  fit: BoxFit.scaleDown,
                                  child: Text(prod.store?.name ?? 'brand', style: TStyle.mainwSemi(13)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const HorizontalSpacing(8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const VectorGraphicsWidget(Assets.soldCartIc),
                          const HorizontalSpacing(2),
                          Text(L10n.tr().sold, style: TStyle.robotBlackSmall()),
                          Text(' +${prod.sold}', style: TStyle.robotBlackSmall().copyWith(color: Co.darkGrey)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Helpers.getProperPrice(prod.price), style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple)),
                      const HorizontalSpacing(8),
                      CartToIncrementIcon(isHorizonal: true, product: prod, iconSize: 25, isDarkContainer: true),
                    ],
                  ),
                ],
              ),
            ),

            //  Text(L10n.tr().onAllGrills, style: TStyle.blackSemi(12)),
          ],
        ),
      ),
    );
  }
}
