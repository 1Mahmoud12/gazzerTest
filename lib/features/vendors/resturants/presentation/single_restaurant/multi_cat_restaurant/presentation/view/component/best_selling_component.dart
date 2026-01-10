part of '../multi_cat_restaurant_screen.dart';

class _BestSellingComponent extends StatelessWidget {
  const _BestSellingComponent({required this.bestSelling, required this.isCardDisabled});

  final List<PlateEntity> bestSelling;
  final bool isCardDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(L10n.tr().bestSellingItems, style: context.style20500.copyWith(color: Co.purple)),
          ),
          const VerticalSpacing(8),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: bestSelling.map((e) => _TopRatedCard(e)).toList()),
          ),
        ],
      ),
    );
  }
}
