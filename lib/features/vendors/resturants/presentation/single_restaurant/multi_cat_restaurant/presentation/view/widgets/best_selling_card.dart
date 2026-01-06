part of '../multi_cat_restaurant_screen.dart';

class _BestSellingCard extends StatelessWidget {
  const _BestSellingCard(this.product);

  final GenericItemEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacityNew(0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: InkWell(
        onTap: () {
          PlateDetailsRoute(id: product.id).push(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: CustomNetworkImage(product.image, fit: BoxFit.cover, width: double.infinity),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (product.orderCount != null && product.orderCount! > 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                '${L10n.tr().totalUnitSolid}: ',
                                style: TStyle.robotBlackSmall().copyWith(color: Co.purple),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const HorizontalSpacing(5),
                          Text('${product.orderCount ?? 0}', style: TStyle.robotBlackSmall().copyWith(color: Co.purple)),
                        ],
                      ),

                    Text(
                      product.description,
                      style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Helpers.getProperPrice(product.price), style: TStyle.robotBlackSmall().copyWith(color: Co.purple)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Co.second2, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              product.rate.toStringAsFixed(1),
                              style: TStyle.robotBlackThin().copyWith(color: Co.secondary, fontWeight: TStyle.bold),
                            ),
                          ],
                        ),
                      ],
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
