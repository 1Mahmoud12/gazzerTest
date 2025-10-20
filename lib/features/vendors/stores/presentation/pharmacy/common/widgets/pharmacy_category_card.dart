import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';

/// Reusable category card for pharmacy categories with image, name, and rating
class PharmacyCategoryCard extends StatelessWidget {
  const PharmacyCategoryCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    this.onTap,
  });

  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Image
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Co.purple.withOpacity(.6),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),

                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomNetworkImage(
                        'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
                        width: constraints.maxWidth,
                        height: 90,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),

            // Category Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Name
                  Text(
                    name,
                    style: TStyle.burbleBold(14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Rating
                  _buildRating(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRating() {
    // Row(
    //   children: [
    //     const Icon(Icons.favorite, color: Co.secondary, size: 18),
    //     const Spacer(),
    //     Text(
    //       product.rate.toStringAsFixed(1),
    //       style: TStyle.secondaryBold(12),
    //     ),
    //     Text(
    //       " ( ${product.reviewCount.toInt()} )",
    //       style: TStyle.blackBold(12),
    //     ),
    //     const Spacer(),
    //   ],
    // ),
    return Row(
      children: [
        const Icon(Icons.star, color: Co.secondary, size: 18),

        const Spacer(),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TStyle.secondaryBold(12),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: TStyle.greyBold(11),
        ),
      ],
    );
  }
}
