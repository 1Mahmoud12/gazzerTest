import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';

class GrocProdCard extends StatelessWidget {
  const GrocProdCard({super.key, required this.product, required this.shape});
  final ProductEntity product;
  final CardStyle shape;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppConst.defaultBorderRadius,
      onTap: () {
        ProductDetailsRoute(productId: product.id).push(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x88FF9F08),
                        offset: Offset(0, 0),
                        blurRadius: 80,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0x20504164),
                      borderRadius: CardStyle.getShapeRadius(shape),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.all(8),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: CardStyle.getShapeRadius(shape),
                          child: CustomNetworkImage(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 6,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedFavoriteWidget(
                        fovorable: product,
                        isDarkContainer: false,
                        size: 18,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      CartToIncrementIcon(
                        isHorizonal: false,
                        product: product,
                        iconSize: 20,
                        isDarkContainer: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: AppConst.defaultHrPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TStyle.primaryBold(12, font: FFamily.inter),
                  ),
                  if (product.orderCount != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '${L10n.tr().totalUnitSolid}: ',
                              style: TStyle.primaryBold(10, font: FFamily.inter),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const HorizontalSpacing(5),
                        Text(
                          '${product.orderCount ?? 0}',
                          style: TStyle.primaryBold(12, font: FFamily.inter),
                        ),
                      ],
                    ),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      spacing: 16,
                      children: [
                        GradientTextWzShadow(
                          text: product.price.toStringAsFixed(2),
                          shadow: AppDec.blackTextShadow.first,
                          style: TStyle.blackBold(12, font: FFamily.inter),
                        ),
                        GradientTextWzShadow(
                          text: L10n.tr().egp,
                          shadow: AppDec.blackTextShadow.first,
                          style: TStyle.blackBold(12, font: FFamily.inter),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Co.secondary, size: 18),
                      const Spacer(),
                      Text(
                        product.rate.toStringAsFixed(1),
                        style: TStyle.secondaryBold(12),
                      ),
                      Text(
                        " ( ${product.reviewCount.toInt()} )",
                        style: TStyle.blackBold(12),
                      ),
                      const Spacer(),
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
