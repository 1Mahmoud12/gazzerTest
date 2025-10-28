part of '../multi_cat_restaurant_screen.dart';

class _BestSellingComponent extends StatelessWidget {
  const _BestSellingComponent({
    required this.bestSelling,
    required this.isCardDisabled,
  });

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  L10n.tr().bestSellingItems,
                  style: TStyle.blackBold(20),
                ),
                const SizedBox(height: 4),
                Text(
                  L10n.tr().exploreTheBestMeals,
                  style: TStyle.greyRegular(14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: bestSelling.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AbsorbPointer(
                    absorbing: isCardDisabled,
                    child: _BestSellingCard(bestSelling[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
