import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class ProductSummaryWidget extends StatelessWidget {
  const ProductSummaryWidget({super.key, required this.plate});
  final PlateEntity plate;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(plate.name, style: context.style20500),
        const SizedBox(height: 8),
        Text(plate.description, style: context.style14400.copyWith(color: Co.darkGrey)),
      ],
    );
  }
}
