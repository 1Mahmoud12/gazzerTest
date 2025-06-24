import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';

class MiniProductCard extends StatelessWidget {
  const MiniProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => DecoratedBox(
        decoration: BoxDecoration(
          border: GradientBoxBorder(gradient: Grad.shadowGrad()),
          borderRadius: AppConst.defaultBorderRadius,
        ),
        child: SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxHeight * 0.71,
          child: InkWell(
            onTap: () => AppNavigator().push(AddFoodToCartScreen(product: product)),
            borderRadius: AppConst.defaultBorderRadius,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleGradientBorderedImage(image: product.image),
                      Expanded(
                        child: Center(
                          child: Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: Grad.bgLinear.copyWith(
                        colors: [const Color(0xAA402788), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      shape: BoxShape.circle,
                      border: GradientBoxBorder(gradient: Grad.shadowGrad()),
                    ),
                    child: const FavoriteWidget(size: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
