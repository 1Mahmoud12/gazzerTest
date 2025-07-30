import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';

class GrocSubCatCard extends StatelessWidget {
  const GrocSubCatCard({super.key, required this.subCat, required this.shape});
  final StoreCategoryEntity subCat;
  final CardStyle shape;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x88FF9F08),
                offset: Offset(0, 0),
                blurRadius: 80,
                spreadRadius: 0,
              ),
            ],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0x20504164),
              borderRadius: CardStyle.getShapeRadius(shape),
            ),
            child: Padding(
              padding: const EdgeInsetsGeometry.all(8),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: CardStyle.getShapeRadius(shape),
                  child: CustomNetworkImage(
                    subCat.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              subCat.name,
              style: TStyle.primaryBold(12, font: FFamily.inter),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
