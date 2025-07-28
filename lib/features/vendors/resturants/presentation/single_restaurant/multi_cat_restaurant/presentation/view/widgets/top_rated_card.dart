part of '../multi_cat_restaurant_screen.dart';

class _TopRatedCard extends StatelessWidget {
  const _TopRatedCard(this.product);
  final GenericItemEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: Grad().bglightLinear,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(24), bottomLeft: Radius.circular(24)),
      ),
      child: InkWell(
        onTap: () {
          AddFoodToCartRoute($extra: product).push(context);
        },
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: CustomNetworkImage(product.image, fit: BoxFit.cover, width: double.infinity),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: product.name, style: TStyle.blackBold(13)),
                          const TextSpan(text: '\n'),
                          TextSpan(text: product.description, style: TStyle.whiteRegular(12)),
                        ],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        crossAxisAlignment: WrapCrossAlignment.center,

                        children: [
                          Text(Helpers.getProperPrice(product.price), style: TStyle.blackBold(10)),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: Co.second2, size: 16),
                              Text(product.rate.toStringAsFixed(1), style: TStyle.secondaryBold(10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
