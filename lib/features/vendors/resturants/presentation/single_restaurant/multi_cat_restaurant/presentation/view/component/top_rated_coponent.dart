part of '../multi_cat_restaurant_screen.dart';

class _TopRatedComponent extends StatelessWidget {
  const _TopRatedComponent({required this.toprated, required this.isCardDisabled});
  final List<PlateEntity> toprated;
  final bool isCardDisabled;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Stack(
        children: [
          OverflowBox(
            maxHeight: 340,
            minHeight: 340,
            alignment: Alignment.topCenter,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: CircularCarousalWidget(
                itemsCount: toprated.length,
                maxItemWidth: 120,
                itemBuilder: (BuildContext context, int index) {
                  return AbsorbPointer(absorbing: isCardDisabled, child: _TopRatedCard(toprated[index]));
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GradientText(text: L10n.tr().topRated, style: TStyle.blackBold(24)),
                Text(L10n.tr().exploreTheBestMeals, style: TStyle.blackBold(14)),
                const VerticalSpacing(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
