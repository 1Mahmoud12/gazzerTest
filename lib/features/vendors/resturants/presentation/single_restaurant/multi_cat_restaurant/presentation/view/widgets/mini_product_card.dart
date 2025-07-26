part of '../multi_cat_restaurant_screen.dart';

class _MiniProductCard extends StatelessWidget {
  const _MiniProductCard({required this.prod});
  final GenericItemEntity prod;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(100),
          topRight: const Radius.circular(100),
          bottomLeft: Radius.circular(AppConst.defaultInnerRadius),
          bottomRight: Radius.circular(AppConst.defaultInnerRadius),
        ),
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 4, offset: Offset(0, 0))],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: const Radius.circular(30)),
              child: Image.network(prod.image, fit: BoxFit.cover),
            ),
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
