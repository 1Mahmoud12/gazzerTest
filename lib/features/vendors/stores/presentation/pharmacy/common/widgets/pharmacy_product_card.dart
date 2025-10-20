import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

/// Reusable circular product card for pharmacy best sellers
class PharmacyProductCard extends StatelessWidget {
  const PharmacyProductCard({
    super.key,
    required this.product,
    required this.vendorName,
    this.onTap,
  });

  final ProductEntity product;
  final String vendorName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Co.buttonGradient.withOpacity(.1), // Light purple background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(L10n.isAr(context) ? 20 : 200),
            bottomLeft: Radius.circular(L10n.isAr(context) ? 20 : 200),
            topRight: Radius.circular(L10n.isAr(context) ? 200 : 20),
            bottomRight: Radius.circular(L10n.isAr(context) ? 200 : 20),
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
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Co.buttonGradient.withOpacity(.35),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Product Image
                        ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: CustomNetworkImage(
                              'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', //product.image,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 80,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Product Name
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          child: Text(
                            product.name,
                            style: TStyle.burbleBold(16),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            fovorable: product,
                            isDarkContainer: false,
                            size: 18,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          const SizedBox(height: 12),

                          Text(
                            'EG',
                            style: TStyle.blackBold(16),
                          ),
                          const SizedBox(height: 12),
                          const Icon(
                            Icons.star,
                            color: Co.secondary,
                            size: 18,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CartToIncrementIcon(
                            isHorizonal: false,
                            product: product,
                            iconSize: 20,
                            isDarkContainer: false,
                          ),
                          const SizedBox(height: 12),

                          Text(
                            product.price.toStringAsFixed(0),
                            style: TStyle.blackBold(16),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            product.rate.toStringAsFixed(2),
                            style: TStyle.blackBold(
                              14,
                            ).copyWith(color: Co.secondary),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  Text(
                    vendorName,
                    style: TStyle.greyRegular(14),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the rounded rectangle shape behind the product
class ProductCardShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;

    // Create a rounded rectangle shape that fits within the circle
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: width * 0.7,
        height: height * 0.8,
      ),
      const Radius.circular(40),
    );

    path.addRRect(rect);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CardBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Co.buttonGradient.withOpacity(.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final margin = 8.0;
    final borderRadius = 32.0;
    final width = size.width - (margin * 2);
    final height = size.height - (margin * 2);

    // Calculate the semi-circle bulge amount
    final bulgeDx = 30.0; // How much the semi-circle extends outward

    // Start from top center of left edge
    path.moveTo(margin + borderRadius, margin);

    // Top edge (partial, just the corner)
    path.arcToPoint(
      Offset(margin, margin + borderRadius),
      radius: Radius.circular(borderRadius),
      clockwise: false,
    );

    // Left side with semi-circle bulge
    // Draw the bulging semi-circle curve
    final leftMidY = margin + height / 2;

    // Upper curve of the semi-circle
    path.quadraticBezierTo(
      margin - bulgeDx,
      margin + height * 0.3,
      margin - bulgeDx,
      leftMidY,
    );

    // Lower curve of the semi-circle
    path.quadraticBezierTo(
      margin - bulgeDx,
      margin + height * 0.7,
      margin,
      size.height - margin - borderRadius,
    );

    // Bottom-left corner
    path.arcToPoint(
      Offset(margin + borderRadius, size.height - margin),
      radius: Radius.circular(borderRadius),
      clockwise: false,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
