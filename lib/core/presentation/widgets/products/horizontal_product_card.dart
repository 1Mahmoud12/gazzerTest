import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/widgets/products/rating_widget.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/product/presentation/add_prodct_to_cart_screen.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 140),
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: () => context.myPush(AddProdctToCartScreen(product: product)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  width: constraints.maxWidth - 55,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [Co.purple.withAlpha(25), Co.purple],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.5],
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                    child: Row(
                      children: [
                        const HorizontalSpacing(55),
                        Expanded(
                          child: Padding(
                            padding: AppConst.defaultPadding,
                            child: Column(
                              spacing: 6,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GradientText(
                                  text: product.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  gradient: Grad.radialGradient,
                                ),
                                Text(
                                  product.description,
                                  style: TStyle.blackSemi(14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                RatingWidget(product.rate.toStringAsFixed(1), ignoreGesture: true, itemSize: 16),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              style: IconButton.styleFrom(padding: EdgeInsets.zero),
                              icon: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: GradientBoxBorder(gradient: Grad.shadowGrad()),
                                  gradient: Grad.bgLinear.copyWith(
                                    stops: const [0.0, 1],
                                    colors: [const Color(0x55402788), Colors.transparent],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SvgPicture.asset(
                                    Assets.assetsSvgCart,
                                    height: 24,
                                    width: 24,
                                    colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: GradientBoxBorder(gradient: Grad.shadowGrad()),
                                gradient: Grad.bgLinear.copyWith(
                                  stops: const [0.0, 1],
                                  colors: [const Color(0x55402788), Colors.transparent],
                                ),
                              ),
                              child: const FavoriteWidget(size: 24),
                            ),
                          ],
                        ),
                        const HorizontalSpacing(12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 110,
                child: CircleGradientBorderedImage(
                  image: product.image,
                  showBorder: false,
                  shadow: const BoxShadow(color: Colors.black38, offset: Offset(0, 2), blurRadius: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
