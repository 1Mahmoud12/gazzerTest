import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';

enum GrocPodShape { semiCircular, circular, square, elliptical }

class GrocSubCatCard extends StatelessWidget {
  const GrocSubCatCard({super.key, required this.subCat, required this.shape});
  final StoreCategoryEntity subCat;
  final GrocPodShape shape;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              borderRadius: getShapeRadius(shape),
            ),
            child: Padding(
              padding: const EdgeInsetsGeometry.all(8),
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomNetworkImage(
                  subCat.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: AppConst.defaultHrPadding,
          child: Expanded(
            child: Text(
              subCat.name,
              style: TStyle.primaryBold(12, font: FFamily.inter),
            ),
          ),
        ),
      ],
    );
  }

  BorderRadius getShapeRadius(GrocPodShape shape) {
    switch (shape) {
      case GrocPodShape.elliptical:
        return const BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(50),
        );
      case GrocPodShape.circular:
        return BorderRadius.circular(100);
      case GrocPodShape.semiCircular:
        return const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100));
      case GrocPodShape.square:
        return BorderRadius.circular(16);
    }
  }
}
