import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';
import 'package:gazzer/main.dart';

class CardRestInfoWidget extends StatelessWidget {
  const CardRestInfoWidget({super.key, required this.vendor});

  final GenericVendorEntity vendor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Co.purple100),
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              navigateToVendor(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(vendor.name, style: TStyle.robotBlackMedium(), maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                Row(
                  spacing: 4,
                  children: [
                    const VectorGraphicsWidget(Assets.starRateIc),

                    Text(vendor.rate.toStringAsFixed(1), style: TStyle.robotBlackRegular()),
                  ],
                ),
              ],
            ),
          ),
          // if (vendor.tag != null && vendor.tag!.isNotEmpty)
          //   Text(vendor.shortTag(25)!, style: TStyle.robotBlackSmall().copyWith(color: Co.secondary), maxLines: 1, overflow: TextOverflow.ellipsis),
          const VerticalSpacing(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  vendor.description == '' ? vendor.name : vendor.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TStyle.robotBlackMedium().copyWith(color: Co.darkGrey),
                ),
              ),
            ],
          ),
          const VerticalSpacing(8),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const VectorGraphicsWidget(Assets.locationIc, width: 16, height: 16, colorFilter: ColorFilter.mode(Co.black, BlendMode.srcIn)),
                    const HorizontalSpacing(2),
                    Expanded(
                      child: Text(
                        vendor.zoneName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TStyle.robotBlackRegular14().copyWith(color: Co.darkGrey),
                      ),
                    ),
                  ],
                ),
              ),
              if (vendor.deliveryTime != null)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const VectorGraphicsWidget(Assets.clockIc, width: 16, height: 16, colorFilter: ColorFilter.mode(Co.black, BlendMode.srcIn)),
                      const HorizontalSpacing(2),
                      Expanded(
                        child: Text(
                          '${vendor.deliveryTime!} ${L10n.tr().min}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TStyle.robotBlackRegular14(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const VerticalSpacing(8),
          MainBtn(
            onPressed: () {
              navigateToVendor(context);
            },
            // isEnabled: false,
            text: L10n.tr().viewVendor,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
          ),
        ],
      ),
    );
  }

  void navigateToVendor(BuildContext context) {
    logger.d(vendor.storeCategoryType);
    if ((vendor.storeCategoryType ?? '').toLowerCase() == VendorType.pharmacy.name) {
      PharmacyStoreScreenRoute(id: vendor.id).push(context);
    } else if ((vendor.storeCategoryType ?? '').toLowerCase() == VendorType.grocery.name) {
      StoreDetailsRoute(storeId: vendor.id).push(context);
    } else if ((vendor.storeCategoryType ?? '').toLowerCase() == VendorType.restaurant.name) {
      RestaurantDetailsRoute(id: vendor.id).push(context);
    }
  }
}
