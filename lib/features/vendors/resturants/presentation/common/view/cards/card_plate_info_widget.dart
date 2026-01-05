import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class CardPlateInfoWidget extends StatelessWidget {
  const CardPlateInfoWidget({super.key, required this.plate});
  final GenericItemEntity plate;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plate.name,
          style: TStyle.robotBlackRegular14().copyWith(color: Co.purple),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        Row(
          spacing: 4,
          children: [
            const Icon(Icons.star, color: Co.tertiary, size: 18),
            const HorizontalSpacing(8),
            Text(plate.rate.toStringAsFixed(2), style: TStyle.robotBlackRegular14().copyWith(color: Co.tertiary)),
            Text('(${plate.reviewCount})', style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold)),
          ],
        ),

        Row(
          spacing: 16,
          children: [
            Text(plate.price.toStringAsFixed(2), style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold)),
            Text('EGP', style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold)),
          ],
        ),
      ],
    );
  }
}
