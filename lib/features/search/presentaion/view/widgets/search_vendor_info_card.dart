import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
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
          CustomNetworkImage(
            vendor.image,
            height: 86,
            width: 86,
            fit: BoxFit.cover,
            borderRaduis: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vendor.name, style: TStyle.primaryBold(16)),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Helpers.shortIrretableStrings(vendor.tags ?? [], 25) ?? '',
                            style: TStyle.secondarySemi(12),
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              const Icon(Icons.location_on, color: Co.purple, size: 18),
                              Text(
                                vendor.zoneName,
                                style: TStyle.secondarySemi(12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Co.second2, size: 20),
                        Icon(Icons.access_time_rounded, color: Co.purple, size: 18),
                      ],
                    ),
                    const HorizontalSpacing(4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 4,
                          children: [
                            Text(
                              vendor.rate.toStringAsFixed(1),
                              style: TStyle.secondarySemi(12),
                            ),
                            Text(
                              "(${vendor.rateCount})",
                              style: TStyle.greySemi(12),
                            ),
                          ],
                        ),
                        Text(
                          "${vendor.deliveryTime} ${L10n.tr().mins}",
                          style: TStyle.secondarySemi(12),
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
