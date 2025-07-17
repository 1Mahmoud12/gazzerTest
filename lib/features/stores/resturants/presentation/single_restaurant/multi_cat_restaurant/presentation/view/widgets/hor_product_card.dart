part of '../multi_cat_restaurant_screen.dart';

class _HorProductCard extends StatelessWidget {
  const _HorProductCard({required this.prod});
  final ProductItemEntity prod;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 215,
      child: InkWell(
        onTap: () {
          AddFoodToCartRoute($extra: prod).push(context);
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: Row(
                children: [
                  const HorizontalSpacing(80),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: Grad().bglightLinear,
                        borderRadius: AppConst.defaultBorderRadius,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DecoratedFavoriteWidget(
                                isDarkContainer: false,
                                size: 22,
                                padding: 4,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 6,
                                children: [
                                  const Icon(Icons.star, size: 24, color: Co.secondary),
                                  Text(prod.rate.toStringAsFixed(1), style: TStyle.secondaryBold(14)),
                                ],
                              ),
                              Text(Helpers.getProperPrice(prod.price), style: TStyle.blackBold(12)),
                            ],
                          ),
                          const HorizontalSpacing(12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ImageInNestedCircles(imageRatio: 4, image: prod.image),
          ],
        ),
      ),
    );
  }
}
