import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class CardRestInfoWidget extends StatelessWidget {
  const CardRestInfoWidget({super.key, required this.vendor});

  final GenericVendorEntity vendor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Co.purple100),
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          // if (vendor.tag != null && vendor.tag!.isNotEmpty)
          //   Text(vendor.shortTag(25)!, style: TStyle.secondarySemi(12), maxLines: 1, overflow: TextOverflow.ellipsis),
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
                    const VectorGraphicsWidget(Assets.locationIc, width: 16, height: 16),
                    const HorizontalSpacing(2),
                    Expanded(
                      child: Text(
                        vendor.zoneName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TStyle.robotBlackMedium().copyWith(color: Co.darkGrey),
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
                      const VectorGraphicsWidget(Assets.clockIc, width: 16, height: 16),
                      const HorizontalSpacing(2),
                      Expanded(
                        child: Text(vendor.deliveryTime!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TStyle.greySemi(13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const VerticalSpacing(8),
          MainBtn(
            onPressed: () {},
            isEnabled: false,
            text: L10n.tr().viewVendor,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
          ),
        ],
      ),
    );
  }
}
