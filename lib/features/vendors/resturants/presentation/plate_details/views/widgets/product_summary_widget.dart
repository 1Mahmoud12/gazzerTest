import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class ProductSummaryWidget extends StatelessWidget {
  const ProductSummaryWidget({super.key, required this.plate});
  final PlateEntity plate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: GradientText(
                textAlign: TextAlign.start,
                text: plate.name,
                style: TStyle.blackBold(20),
                gradient: Grad().textGradient,
              ),
            ),
            Text(
              Helpers.getProperPrice(plate.price),
              style: TStyle.blackBold(14).copyWith(shadows: AppDec.blackTextShadow),
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Expanded(child: Text(plate.description, style: TStyle.blackRegular(14))),
            const Icon(Icons.star, color: Co.secondary, size: 20),
            Text(plate.rate.toStringAsFixed(1), style: TStyle.secondaryBold(13)),
          ],
        ),
      ],
    );
  }
}
