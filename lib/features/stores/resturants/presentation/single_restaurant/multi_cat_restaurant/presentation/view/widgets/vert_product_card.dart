part of '../multi_cat_restaurant_screen.dart';

class _VertProductCard extends StatelessWidget {
  const _VertProductCard({required this.prod});
  final ProductModel prod;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 138,
      child: InkWell(
        onTap: () {
          AppNavigator().push(AddFoodToCartScreen(product: prod));
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox.expand(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(gradient: Grad().bglightLinear, borderRadius: AppConst.defaultBorderRadius),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                          DecoratedFavoriteWidget(isDarkContainer: false, size: 22, padding: 4, borderRadius: BorderRadius.circular(100)),
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
