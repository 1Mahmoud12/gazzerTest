part of '../multi_cat_restaurant_screen.dart';

class _TopRatedCard extends StatelessWidget {
  const _TopRatedCard(this.product);
  final GenericItemEntity product;

  @override
  Widget build(BuildContext context) {
    final plate = product is PlateEntity ? product as PlateEntity : null;
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Co.lightGrey),
      ),
      child: InkWell(
        onTap: () {
          PlateDetailsRoute(id: product.id).push(context);
        },
        child: Row(
          children: [
            // Left side - Image with favorite icon
            Stack(
              children: [
                CustomNetworkImage(product.image, fit: BoxFit.cover, width: 100, height: 100, borderRaduis: 20),
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: FavoriteWidget(padding: 2, fovorable: product),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Right side - Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Restaurant/Store name
                            Row(
                              children: [
                                Expanded(
                                  child: Text(product.name, style: TStyle.robotBlackMedium(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (product.offer != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  '${product.offer!.discount}${product.offer!.discountType == DiscountType.percentage ? '%' : ''}',
                                  style: TStyle.robotBlackMedium(),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // Rating and Review count
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const VectorGraphicsWidget(Assets.starRateIc),
                                const SizedBox(width: 4),
                                Text(product.rate.toStringAsFixed(1), style: TStyle.blackBold(14)),
                                if (product.reviewCount > 0) ...[
                                  const SizedBox(width: 4),
                                  Text('(+${product.reviewCount})', style: TStyle.greyRegular(12)),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (plate != null && plate.sold > 0)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const VectorGraphicsWidget(Assets.soldCartIc),
                                  const HorizontalSpacing(2),
                                  Text(L10n.tr().sold, style: TStyle.robotBlackSmall()),
                                  Text(' +${product.sold}', style: TStyle.robotBlackSmall().copyWith(color: Co.darkGrey)),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Helpers.getProperPrice(product.price), style: TStyle.primaryBold(16)),
                              if (product.priceBeforeDiscount != null)
                                Text(
                                  Helpers.getProperPrice(product.priceBeforeDiscount!),
                                  style: TStyle.greyRegular(12).copyWith(decoration: TextDecoration.lineThrough),
                                ),
                            ],
                          ),
                        ],
                      ),

                      // Add to cart button
                      if (!(key?.toString().contains('store') ?? false))
                        CartToIncrementIcon(isHorizonal: true, product: product, iconSize: 25, isDarkContainer: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
