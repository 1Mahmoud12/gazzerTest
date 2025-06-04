import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/home/presentaion/utils/product_shape_painter.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/title_with_more.dart';
import 'package:gazzer/features/product/presentation/add_prodct_to_cart_screen.dart';

class HomeBestPopular extends StatelessWidget {
  const HomeBestPopular({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithMore(title: "Best Popular", onPressed: () {}),

        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final prod = Fakers.fakeProds[index];
              return SizedBox(
                width: 125,
                child: InkWell(
                  borderRadius: AppConst.defaultBorderRadius,
                  onTap: () => context.myPush(AddProdctToCartScreen(product: prod)),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: CustomPaint(
                            painter: ProductShapePaint(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    spacing: 6,
                                    children: [
                                      SizedBox(height: 30, child: CircleGradientBorderedImage(image: prod.image)),
                                      Expanded(
                                        child: Text(
                                          prod.name,
                                          style: TStyle.primaryBold(13),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const VerticalSpacing(8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(Helpers.getProperPrice(prod.price), style: TStyle.tertiaryBold(12)),
                                      Row(
                                        children: [
                                          const Icon(Icons.star, color: Co.secondary, size: 16),
                                          Text(prod.rate.toStringAsFixed(1), style: TStyle.secondarySemi(12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text("In all grills", style: TStyle.blackSemi(14)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Transform.rotate(
                          angle: -0.25,
                          child: ClipRRect(
                            borderRadius: AppConst.defaultBorderRadius,
                            child: Image.asset(prod.image, fit: BoxFit.cover, width: 100, height: 60),
                          ),
                        ),
                      ),

                      const Positioned(
                        top: 60,
                        right: 0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Co.mauve,
                            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))],
                          ),
                          child: FavoriteWidget(size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
