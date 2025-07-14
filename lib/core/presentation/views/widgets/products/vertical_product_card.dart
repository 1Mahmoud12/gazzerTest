import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({super.key, required this.product, required this.canAdd, this.fontFactor = 1.0});
  final ProductModel product;
  final bool canAdd;
  final double fontFactor;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: InkWell(
            borderRadius: AppConst.defaultBorderRadius,
            onTap: canAdd
                ? null
                : () {
                    SystemSound.play(SystemSoundType.click);
                    AppNavigator().push(AddFoodToCartScreen(product: product));
                  },

            child: CustomPaint(
              painter: ProductShapePaint(),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: constraints.maxWidth * 0.7,
                            child: CircleGradientBorderedImage(
                              image: product.image,
                              shadow: const BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2)),
                              showBorder: false,
                            ),
                          ),
                          FavoriteWidget(size: 32 * fontFactor),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(product.name, style: TStyle.primaryBold(15 * fontFactor))),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Co.secondary, size: 16),
                                    Text(
                                      product.rate.toStringAsFixed(1),
                                      style: TStyle.mainwSemi(12 * fontFactor).copyWith(color: Co.secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (canAdd)
                              Text(
                                Helpers.getProperPrice(product.price),
                                style: TStyle.blackSemi(12 * fontFactor).copyWith(shadows: AppDec.blackTextShadow),
                              )
                            else
                              SizedBox(
                                width: constraints.maxWidth * 0.55,
                                child: Text(
                                  "Valid until May 15, 2025",
                                  style: TStyle.mainwSemi(12 * fontFactor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: Grad().radialGradient,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: Grad().linearGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: canAdd
                            ? InkWell(
                                onTap: () {
                                  SystemSound.play(SystemSoundType.click);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Icon(Icons.add, color: Co.second2, size: 24 * fontFactor),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  "40%\nOFF",
                                  style: TStyle.mainwBold(11 * fontFactor).copyWith(color: Co.secondary),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
