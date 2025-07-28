import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class CardRestInfoWidget extends StatelessWidget {
  const CardRestInfoWidget({super.key, required this.vendor});
  final RestaurantEntity vendor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vendor.name,
          style: TStyle.primaryBold(14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (vendor.tag != null)
          Text(
             vendor.tag!.join(', '),
            style: TStyle.secondarySemi(12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        Row(
          spacing: 4,
          children: [
            const Icon(Icons.star, color: Co.tertiary, size: 18),
            const Spacer(),
            Text(vendor.rate.toStringAsFixed(2), style: TStyle.blackBold(13).copyWith(color: Co.tertiary)),
            Text("(${vendor.rateCount})", style: TStyle.blackBold(12)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.location_on, color: Co.purple, size: 18),

            Text(vendor.location, style: TStyle.primaryRegular(12)),
          ],
        ),
        if (vendor.deliveryTime != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.access_time_outlined, color: Co.purple, size: 18),
              Text(vendor.deliveryTime!, style: TStyle.greySemi(13)),
            ],
          ),
      ],
    );
  }
}
