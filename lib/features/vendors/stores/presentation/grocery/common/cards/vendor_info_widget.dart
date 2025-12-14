import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class VendorInfoWidget extends StatelessWidget {
  const VendorInfoWidget({super.key, required this.vendor});
  final StoreEntity vendor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: Column(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(vendor.name, style: TStyle.robotBlackRegular(), maxLines: 2, overflow: TextOverflow.ellipsis),

          // if (vendor.tag?.isNotEmpty == true)
          //   Text(vendor.tag!.join(', '), style: TStyle.greyRegular(12), maxLines: 1, overflow: TextOverflow.ellipsis),
          if (vendor.estimatedDeliveryTime != null) ...[
            const VerticalSpacing(4),
            Row(
              spacing: 4,
              children: [
                const VectorGraphicsWidget(Assets.clockIc, height: 24, width: 24, colorFilter: ColorFilter.mode(Co.purple, BlendMode.srcIn)),
                Text('${vendor.estimatedDeliveryTime} ${L10n.tr().min}', style: TStyle.greyRegular(13), overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
          // Row(
          //   spacing: 4,
          //   children: [
          //     const Icon(Icons.star, color: Co.tertiary, size: 20),
          //     const Spacer(),
          //     Text(vendor.rate.toStringAsFixed(2), style: TStyle.blackSemi(12).copyWith(color: Co.tertiary)),
          //     Text("(${vendor.rateCount ?? 0})", style: TStyle.blackSemi(11)),
          //     const Spacer(),
          //   ],
          // ),
          // if (vendor.zoneName.trim().isNotEmpty)
          //   Row(
          //     children: [
          //       const Icon(Icons.location_on, size: 24),
          //       Expanded(
          //         child: Text(vendor.zoneName, style: TStyle.greySemi(12), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
          //       ),
          //     ],
          //   ),
          // if (vendor.deliveryTime != null)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Icon(Icons.access_time_outlined, color: Co.purple, size: 20),
          //       const Spacer(),
          //       Text("${vendor.deliveryTime} ${L10n.tr().min}", style: TStyle.greySemi(12)),
          //       const Spacer(),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
