import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

/// Reusable circular product card for pharmacy best sellers
class PharmacyProductCard extends StatelessWidget {
  const PharmacyProductCard({super.key, required this.product, required this.vendorName, this.width, this.height, this.onTap});

  final ProductEntity product;
  final String vendorName;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Calculate dimensions based on the provided width or screen width
    final cardWidth = width ?? MediaQuery.sizeOf(context).width * 0.8;
    final cardHeight = height ?? (cardWidth * 0.8); // 25% of width for height

    final circleSize = cardWidth * 0.6; // 62.5% of card width (was 0.5 of screen)
    final imageWidth = cardWidth * 0.5; // 50% of card width (was 0.4 of screen)
    final imageHeight = circleSize * 0.36; // Proportional to circle size
    final padding = cardWidth * 0.025; // 2.5% of card width (was 8)
    final largeBorderRadius = cardWidth * 0.625; // For the circular edges (was 200)
    final smallBorderRadius = cardWidth * 0.0625; // For the small corners (was 20)
    final fontSize = cardWidth * 0.05; // Base font size proportional to width
    final iconSize = cardWidth * 0.05625; // Icon size proportional to width
    final spacing = cardWidth * 0.015; // Spacing proportional to width

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: EdgeInsets.symmetric(horizontal: spacing),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Co.buttonGradient.withOpacity(.1), // Light purple background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(L10n.isAr(context) ? smallBorderRadius : largeBorderRadius),
            bottomLeft: Radius.circular(L10n.isAr(context) ? smallBorderRadius : largeBorderRadius),
            topRight: Radius.circular(L10n.isAr(context) ? largeBorderRadius : smallBorderRadius),
            bottomRight: Radius.circular(L10n.isAr(context) ? largeBorderRadius : smallBorderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main circular container with product and info
            // Large circular container
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular border container
                  Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Co.buttonGradient.withOpacity(.35), width: 3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Product Image
                        ClipOval(
                          child: Padding(
                            padding: EdgeInsets.all(spacing * 2.5),
                            child: CustomNetworkImage(
                              'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', //product.image,
                              width: imageWidth,
                              height: imageHeight,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(height: spacing),

                        // Product Name
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding * 2),
                          child: Text(
                            product.name,
                            style: TStyle.burbleBold(fontSize),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: spacing),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Rating and actions
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          DecoratedFavoriteWidget(
                            ignorePointer: true,
                            fovorable: product,
                            isDarkContainer: false,
                            size: iconSize,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          SizedBox(height: spacing * 1.5),

                          Text('EG', style: TStyle.blackBold(fontSize)),
                          SizedBox(height: spacing * 1.5),
                          Icon(Icons.star, color: Co.secondary, size: iconSize),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          FittedBox(
                            child: CartToIncrementIcon(isHorizonal: false, product: product, iconSize: iconSize * 1.1, isDarkContainer: false),
                          ),
                          SizedBox(height: spacing * 1.5),

                          Text(product.price.toStringAsFixed(0), style: TStyle.blackBold(fontSize)),
                          SizedBox(height: spacing * 1.5),
                          Text(product.rate.toStringAsFixed(2), style: TStyle.blackBold(fontSize * 0.875).copyWith(color: Co.secondary)),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  Text(
                    vendorName,
                    style: TStyle.greyRegular(fontSize * 0.875),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spacing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
