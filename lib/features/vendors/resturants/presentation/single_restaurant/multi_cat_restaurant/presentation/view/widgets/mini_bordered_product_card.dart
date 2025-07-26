part of '../multi_cat_restaurant_screen.dart';

class _MiniBorderedProductCard extends StatelessWidget {
  const _MiniBorderedProductCard({required this.prod});
  final GenericItemEntity prod;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Co.bg,
        border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 1.5),
      ),
      child: Column(
        children: [
          ClipOval(
            child: AspectRatio(aspectRatio: 1, child: Image.network(prod.image, fit: BoxFit.cover)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(prod.name, style: TStyle.blackBold(12)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddIcon(
                        onTap: () {
                          SystemSound.play(SystemSoundType.click);
                          AddFoodToCartRoute($extra: prod).push(context);
                        },
                      ),
                      DecoratedFavoriteWidget(
                        isDarkContainer: false,
                        size: 16,
                        padding: 6,
                        borderRadius: AppConst.defaultInnerBorderRadius,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
