part of '../multi_cat_restaurant_screen.dart';

class _MiniBorderedProductCard extends StatelessWidget {
  const _MiniBorderedProductCard({required this.prod});
  final ProductModel prod;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Co.bg,
        border: GradientBoxBorder(gradient: Grad.shadowGrad(), width: 1.5),
      ),
      child: Column(
        children: [
          ClipOval(
            child: AspectRatio(aspectRatio: 1, child: Image.asset(prod.image, fit: BoxFit.cover)),
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
                      DoubledDecoratedWidget(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.add, color: Co.second2, size: 20),
                          ),
                        ),
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
