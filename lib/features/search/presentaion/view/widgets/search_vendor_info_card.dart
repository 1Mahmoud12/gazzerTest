import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/search/domain/search_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';

class SearchVendorInfoCard extends StatelessWidget {
  const SearchVendorInfoCard({super.key, required this.vendor});
  final SearchVendorEntity vendor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (vendor.type) {
          case VendorType.restaurant:
            RestaurantDetailsRoute(id: vendor.id).push(context);
            break;
          case VendorType.grocery:
          case VendorType.pharmacy:
            StoreDetailsRoute(storeId: vendor.id).push(context);
            break;
        }
      },
      borderRadius: AppConst.defaultBorderRadius,
      child: Row(
        spacing: 12,
        children: [
          CustomNetworkImage(vendor.image, height: 75, width: 65, fit: BoxFit.cover, borderRaduis: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(vendor.name, style: TStyle.robotBlackMedium(), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    const HorizontalSpacing(4),
                    Row(
                      children: [
                        const VectorGraphicsWidget(Assets.starRateIc, width: 20, height: 20),
                        const HorizontalSpacing(4),
                        Text(
                          vendor.rate.toStringAsFixed(1),
                          style: context.style16400.copyWith(color: Co.darkGrey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,

                      spacing: 4,
                      children: [
                        const VectorGraphicsWidget(Assets.locationIc, width: 20, height: 20),
                        const HorizontalSpacing(4),
                        Text(
                          vendor.zoneName,
                          style: context.style16400.copyWith(color: Co.darkGrey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const VectorGraphicsWidget(Assets.clockIc, width: 20, height: 20),
                        const HorizontalSpacing(4),
                        Text(
                          '${vendor.deliveryTime} ${L10n.tr().mins}',
                          style: context.style16400.copyWith(color: Co.darkGrey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
