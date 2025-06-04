import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/home/presentaion/utils/product_shape_painter.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
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
                        const FavoriteWidget(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product.name, style: TStyle.primaryBold(18)),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Co.secondary, size: 16),
                                  Text(
                                    product.rate.toStringAsFixed(1),
                                    style: TStyle.mainwSemi(14).copyWith(color: Co.secondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.55,
                            child: Text(
                              "Valid until May 15, 2025",
                              style: TStyle.mainwSemi(14),
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
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text("40%\nOFF", style: TStyle.mainwBold(13).copyWith(color: Co.secondary)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
