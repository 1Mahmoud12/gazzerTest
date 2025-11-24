import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

/// Style 2 pharmacy product card with circular image and side details
class PharmacyProductCardStyle2 extends StatelessWidget {
  const PharmacyProductCardStyle2({
    super.key,
    required this.product,
    required this.vendorName,
    this.width,
    this.height,
    this.onTap,
  });

  final ProductEntity product;
  final String vendorName;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Calculate dimensions based on the provided width or screen width
    final cardWidth = width ?? MediaQuery.sizeOf(context).width * 0.9;
    final cardHeight = height ?? (cardWidth * 0.25); // 25% of width for height
    final padding = cardWidth * 0.02; // 2% of card width
    final fontSize = cardWidth * 0.04; // Base font size proportional to width
    final iconSize = cardWidth * 0.06; // Icon size proportional to width
    final spacing = cardWidth * 0.02; // Spacing proportional to width

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: EdgeInsets.symmetric(horizontal: spacing),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Co.buttonGradient.withOpacity(.1), // Light purple background
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            // Left section - Circular image
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    margin: EdgeInsets.only(top: cardWidth * 0.1),
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                      border: Border.all(
                        color: Co.buttonGradient.withOpacity(.35),
                        width: 2,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: ClipOval(
                            child: CustomNetworkImage(
                              'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', //product.image,
                              width: double.infinity,
                              height: cardWidth * .4,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: spacing),

                        // Product Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            product.name,
                            style: TStyle.burbleBold(fontSize),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: iconSize + spacing),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: spacing * 2),

            // Rating and actions
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            DecoratedFavoriteWidget(
                              ignorePointer: true,
                              fovorable: product,
                              isDarkContainer: false,
                              size: iconSize,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            SizedBox(height: spacing * 1.5),

                            Text(
                              'EG',
                              style: TStyle.blackBold(fontSize),
                            ),
                            SizedBox(height: spacing * 1.5),
                            Icon(
                              Icons.star,
                              color: Co.secondary,
                              size: iconSize,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          children: [
                            CartToIncrementIcon(
                              ignorePointer: true,
                              isHorizonal: false,
                              product: product,
                              iconSize: iconSize * 1.1,
                              isDarkContainer: false,
                            ),
                            SizedBox(height: spacing * 1.5),

                            Text(
                              product.price.toStringAsFixed(0),
                              style: TStyle.blackBold(fontSize),
                            ),
                            SizedBox(height: spacing * 1.5),
                            Text(
                              product.rate.toStringAsFixed(2),
                              style: TStyle.blackBold(
                                fontSize * 0.875,
                              ).copyWith(color: Co.secondary),
                            ),
                          ],
                        ),
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
                  SizedBox(height: spacing + spacing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
