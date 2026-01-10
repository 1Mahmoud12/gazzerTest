import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
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
          boxShadow: [BoxShadow(color: Colors.black.withOpacityNew(0.06), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            // Category Image
            Container(
              margin: const EdgeInsets.all(2),

              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),

                child: CustomNetworkImage(
                  'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
                  width: 107,
                  height: 100,

                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Category Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                name,
                style: context.style16400.copyWith(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
