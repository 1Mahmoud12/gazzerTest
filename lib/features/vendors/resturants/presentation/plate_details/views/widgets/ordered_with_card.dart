import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class OrderedWithCard extends StatelessWidget {
  const OrderedWithCard({super.key, required this.product});
  final OrderedWithEntity product;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: InkWell(
            borderRadius: AppConst.defaultBorderRadius,
            onTap: () {
              SystemSound.play(SystemSoundType.click);
              // AppNavigator().push(AddFoodToCartScreen(product: product));
            },

            child: CustomPaint(
              painter: ProductShapePaint(),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 12,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CircleGradientBorderedImage(
                              image: product.image,
                              shadow: const BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2)),
                              showBorder: false,
                            ),
                          ),
                          FavoriteWidget(size: 24, fovorable: product),
                        ],
                      ),
                      const VerticalSpacing(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(product.name, style: TStyle.primaryBold(15))),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Co.secondary, size: 16),
                                    Text(
                                      product.rate.toStringAsFixed(1),
                                      style: TStyle.mainwSemi(12).copyWith(color: Co.secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              Helpers.getProperPrice(product.price),
                              style: TStyle.blackSemi(12).copyWith(shadows: AppDec.blackTextShadow),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AddIcon(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                      },
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
