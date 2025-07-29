import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

enum GrodPodShape { semiCircular, circular, square, elliptical }

class GrocProdCard extends StatelessWidget {
  const GrocProdCard({super.key, required this.product, required this.shape});
  final ProductEntity product;
  final GrodPodShape shape;
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
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: AppConst.defaultHrPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TStyle.primaryBold(12, font: FFamily.inter),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    spacing: 16,
                    children: [
                      GradientTextWzShadow(
                        text: product.price.toStringAsFixed(2),
                        shadow: AppDec.blackTextShadow.first,
                        style: TStyle.blackBold(12, font: FFamily.inter),
                      ),
                      GradientTextWzShadow(
                        text: 'EG',
                        shadow: AppDec.blackTextShadow.first,
                        style: TStyle.blackBold(12, font: FFamily.inter),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    const Icon(Icons.favorite, color: Co.secondary, size: 18),
                    const Spacer(),
                    Text(
                      product.rate.toStringAsFixed(1),
                      style: TStyle.secondaryBold(12),
                    ),
                    Text(
                      " ( ${product.reviewCount.toInt()} )",
                      style: TStyle.blackBold(12),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BorderRadius getShapeRadius(GrodPodShape shape) {
    switch (shape) {
      case GrodPodShape.elliptical:
        return const BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(50),
        );
      case GrodPodShape.circular:
        return BorderRadius.circular(100);
      case GrodPodShape.semiCircular:
        return const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100));
      case GrodPodShape.square:
        return BorderRadius.circular(16);
    }
  }
}
