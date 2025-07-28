part of '../multi_cat_restaurant_screen.dart';

class _TopRatedComponent extends StatelessWidget {
  const _TopRatedComponent({required this.toprated});
  final List<PlateEntity> toprated;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GradientText(text: L10n.tr().topRated, style: TStyle.blackBold(24)),
        ),
        Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
          child: Text(L10n.tr().exploreTheBestMeals, style: TStyle.blackBold(14)),
        ),
        SizedBox(
          height: 420,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: CircularCarousalWidget(
              itemsCount: Fakers.fakeProds.length,
              maxItemWidth: 128,
              itemBuilder: (BuildContext context, int index) {
                return _TopRatedCard(Fakers.fakeProds[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
