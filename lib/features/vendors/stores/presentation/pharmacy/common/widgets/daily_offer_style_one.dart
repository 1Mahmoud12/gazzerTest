import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

/// Daily offer style one widget - Product card with discount and multiple product images
class DailyOfferStyleOne extends StatelessWidget {
  const DailyOfferStyleOne({super.key, required this.product, this.discountPercentage = 30, this.onTap, this.width});

  final ProductEntity product;
  final int discountPercentage;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final isAr = L10n.isAr(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width * .85,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Co.lightGrey),
        ),
        child: IntrinsicHeight(
          child: Row(
            spacing: 8,
            children: [
              // Top Section - Product Images and Icons
              _TopSection(product: product, discountPercentage: discountPercentage, isAr: isAr),

              // Bottom Section - Product Details
              Expanded(
                child: _BottomSection(product: product, isAr: isAr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection({required this.product, required this.discountPercentage, required this.isAr});

  final ProductEntity product;
  final int discountPercentage;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomNetworkImage(
          height: 110,
          width: 100,
          borderRaduis: 20,
          'https://cdn.thewirecutter.com/wp-content/media/2024/12/ROUNDUP-KOREAN-SKINCARE-2048px-9736-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp',
          fit: BoxFit.fill,
        ),
        FavoriteWidget(fovorable: product),
      ],
    );
  }
}

// class _ProductImagesStack extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Co.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child:
//     );
//   }
// }

class _BottomSection extends StatelessWidget {
  const _BottomSection({required this.product, required this.isAr});

  final ProductEntity product;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Category
        Row(
          children: [
            Expanded(
              child: Text(product.name, style: context.style16500, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            if (product.offer != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Co.secondary, borderRadius: BorderRadius.circular(50)),
                child: Text(
                  '${product.offer!.discount.toInt()}${product.offer!.discountType == DiscountType.percentage ? ' %' : ''}',
                  style: context.style16500,
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 6),

        // Delivery Info
        Row(
          children: [
            Expanded(
              child: Text(
                product.description,
                style: context.style16400.copyWith(color: Co.darkGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ), // Rating
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VectorGraphicsWidget(Assets.starRateIc),
                const HorizontalSpacing(4),
                Text(product.rate.toString(), style: context.style14400),
                const HorizontalSpacing(2),
                Text('(+${product.reviewCount})', style: context.style14400.copyWith(color: Co.darkGrey)),
              ],
            ),
          ],
        ),

        const SizedBox(height: 6),

        // Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(Helpers.getProperPrice(product.price), style: context.style16500.copyWith(color: Co.purple)),
                  ),
                  if (product.offer != null)
                    FittedBox(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        Helpers.getProperPrice(product.priceBeforeDiscount!),
                        style: context.style16500.copyWith(decoration: TextDecoration.lineThrough, color: Co.greyText),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            if (!(key?.toString().contains('store') ?? false))
              CartToIncrementIcon(isHorizonal: true, product: product, iconSize: 25, isDarkContainer: true),
          ],
        ),
      ],
    );
  }
}
