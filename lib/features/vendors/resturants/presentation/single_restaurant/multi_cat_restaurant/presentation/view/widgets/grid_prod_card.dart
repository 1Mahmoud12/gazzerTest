import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';

class SingleGridProduct extends StatelessWidget {
  const SingleGridProduct({super.key, required this.prod, required this.isTop});
  final GenericItemEntity prod;
  final bool isTop;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(
          mainAxisAlignment: isTop ? MainAxisAlignment.start : MainAxisAlignment.end,

          children: [
            SizedBox(
              height: constraints.maxHeight * 0.8,
              child: InkWell(
                onTap: () {
                  PlateDetailsRoute(id: prod.id).push(context);
                },
                borderRadius: AppConst.defaultInnerBorderRadius,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    // border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 1),
                    borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(constraints.maxHeight * 0.2),
                      bottom: Radius.circular(AppConst.defaultRadius),
                    ),
                    gradient: Grad().bglightLinear,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 1),
                            borderRadius: BorderRadius.circular(100),
                            // color: Co.bg,
                          ),
                          child: Row(
                            children: [
                              CircleGradientBorderedImage(image: prod.image, showBorder: true),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: prod.name, style: TStyle.blackSemi(13)),
                                      const TextSpan(text: '\n'),
                                      TextSpan(text: "TEST ", style: TStyle.greyRegular(12)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Co.secondary, size: 18),
                                    Text(prod.rate.toStringAsFixed(1), style: TStyle.secondaryBold(12)),
                                  ],
                                ),
                                Text(Helpers.getProperPrice(prod.price), style: TStyle.blackBold(12)),
                              ],
                            ),
                            DecoratedFavoriteWidget(
                              isDarkContainer: false,
                              size: 18,
                              borderRadius: AppConst.defaultInnerBorderRadius,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
