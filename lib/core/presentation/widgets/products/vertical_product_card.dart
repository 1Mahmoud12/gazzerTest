import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/widgets/main_text_field.dart';
import 'package:gazzer/core/presentation/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/home/presentaion/utils/product_shape_painter.dart';
import 'package:gazzer/features/product/presentation/add_prodct_to_cart_screen.dart';

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
                    context.myPush(AddProdctToCartScreen(product: product));
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
                                Expanded(child: Text(product.name, style: TStyle.primaryBold(18 * fontFactor))),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Co.secondary, size: 16),
                                    Text(
                                      product.rate.toStringAsFixed(1),
                                      style: TStyle.mainwSemi(14 * fontFactor).copyWith(color: Co.secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (canAdd)
                              Text(
                                Helpers.getProperPrice(product.price),
                                style: TStyle.blackSemi(14 * fontFactor).copyWith(shadows: AppDec.blackTextShadow),
                              )
                            else
                              SizedBox(
                                width: constraints.maxWidth * 0.55,
                                child: Text(
                                  "Valid until May 15, 2025",
                                  style: TStyle.mainwSemi(14 * fontFactor),
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
                        gradient: Grad.radialGradient,
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
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.add, color: Co.second2, size: 32),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                "40%\nOFF",
                                style: TStyle.mainwBold(13 * fontFactor).copyWith(color: Co.secondary),
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
