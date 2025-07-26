part of '../restaurants_of_category_screen.dart';

class _ExploreBest extends StatelessWidget {
  const _ExploreBest();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: GradientText(text: L10n.tr().exploreBest, style: TStyle.blackBold(24)),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          padding: AppConst.defaultHrPadding,
          separatorBuilder: (context, index) => const VerticalSpacing(16),
          itemBuilder: (context, index) {
            final vendor = Fakers.restaurants[index];
            return SizedBox(
              height: 140,
              child: LayoutBuilder(
                builder: (context, constraints) => InkWell(
                  borderRadius: AppConst.defaultBorderRadius,
                  onTap: () {
                    if (vendor.id.isEven) {
                      SingleCatRestaurantRoute(id: vendor.id).push(context);
                    } else {
                      MultiCatRestaurantsRoute(id: vendor.id).push(context);
                    }
                  },
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentLocale.centerEnd(context),
                        child: SizedBox(
                          width: constraints.maxWidth - (constraints.maxHeight / 2),
                          child: DecoratedBox(
                            decoration: BoxDecoration(gradient: Grad().bglightLinear, borderRadius: AppConst.defaultBorderRadius),
                            child: Row(
                              children: [
                                const HorizontalSpacing(70),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GradientText(text: vendor.name, style: TStyle.blackBold(20)),
                                            DecoratedFavoriteWidget(size: 20, isDarkContainer: false, borderRadius: AppConst.defaultInnerBorderRadius),
                                          ],
                                        ),
                                        GradientTextWzShadow(
                                          text: Helpers.getProperPrice(50.0),
                                          style: TStyle.blackSemi(16),
                                          shadow: AppDec.blackTextShadow.first,
                                        ),
                                        AppRatingWidget(vendor.rate.toStringAsFixed(1), itemSize: 14),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ImageInNestedCircles(imageRatio: 4, image: vendor.image),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
