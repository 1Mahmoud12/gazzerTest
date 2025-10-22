import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

/// Card widget for displaying pharmacy vendor information
class PharmacyVendorCard extends StatelessWidget {
  const PharmacyVendorCard({
    super.key,
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.deliveryTime,
    this.discountPercentage,
    this.isClosed = false,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  final int id;
  final String name;
  final String logoUrl;
  final double rating;
  final int reviewCount;
  final String location;
  final String deliveryTime;
  final int? discountPercentage;
  final bool isClosed;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isClosed ? Co.closed.withOpacity(0.2) : Co.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isClosed ? Co.purple.withOpacity(0.1) : Co.purple.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Logo with discount/closed badge
            Stack(
              children: [
                // Logo
                Stack(
                  alignment: AlignmentGeometry.bottomCenter,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: CircleGradientBorderedImage(
                        image: logoUrl,
                        showBorder: false,
                      ),
                    ),
                    if (discountPercentage != null)
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(color: Co.secondary, shape: BoxShape.circle),
                        child: Text(
                          '$discountPercentage%',
                          style: TStyle.whiteBold(12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),

                // Discount or Closed Badge
                if (isClosed)
                  Container(
                    width: 60,
                    height: 60,
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Co.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: FittedBox(
                      child: Text(
                        L10n.tr().closed,
                        style: TStyle.burbleBold(15),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Vendor Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    name,
                    style: TStyle.burbleBold(19).copyWith(color: Co.mauve),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Top Rated + Rating
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Top Rated',
                            style: TStyle.mainwSemi(
                              12,
                            ).copyWith(color: Co.tertiary),
                          ),
                          const VerticalSpacing(4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Co.purple,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              SizedBox(
                                width: 60,
                                child: Flexible(
                                  child: Text(
                                    location,
                                    style: TStyle.greySemi(12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Co.tertiary,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$rating ( $reviewCount )',
                                style: TStyle.blackBold(12).copyWith(color: Co.tertiary),
                              ),
                            ],
                          ),
                          VerticalSpacing(4),
                          // Delivery Time
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Co.purple,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                deliveryTime,
                                style: TStyle.greySemi(12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Favorite Button
            DecoratedFavoriteWidget(
              fovorable: ProductEntity(
                id: id,
                name: name,
                description: 'description',
                price: 21,
                image: 'image',
                rate: 12,
                reviewCount: reviewCount,
                outOfStock: false,
              ),
              isDarkContainer: false,
              size: 20,
              borderRadius: BorderRadius.circular(100),
            ),
          ],
        ),
      ),
    );
  }
}
