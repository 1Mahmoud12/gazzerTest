import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';

/// Pharmacy reviews section widget
class PharmacyReviewsSection extends StatelessWidget {
  const PharmacyReviewsSection({super.key, this.onViewAll});

  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final isAr = L10n.isAr(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          HeaderSection(isAr: isAr, onViewAll: onViewAll),

          const VerticalSpacing(16),

          // Divider
          Container(height: 1, color: Co.grey.withOpacityNew(0.3)),

          const VerticalSpacing(20),

          // Reviews List
          ReviewsList(isAr: isAr),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.isAr, this.onViewAll});

  final bool isAr;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithMore(title: L10n.tr().reviews, titleStyle: TStyle.robotBlackSubTitle(), onPressed: onViewAll),
        const VerticalSpacing(12),
        Row(
          children: [
            Expanded(
              child: Text(L10n.tr(context).typeYouReviewHere, style: TStyle.burbleRegular(12), overflow: TextOverflow.ellipsis, maxLines: 1),
            ),

            const HorizontalSpacing(4),
            const Spacer(),
            Text('4.6', style: TStyle.blackRegular(14), overflow: TextOverflow.ellipsis, maxLines: 1),
            const HorizontalSpacing(4),
            ...List.generate(
              5,
              (index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(Icons.star, color: Co.tertiary),
              ),
            ),
            const HorizontalSpacing(4),
            Text('(1120)', style: TStyle.blackRegular(14), overflow: TextOverflow.ellipsis, maxLines: 1),
          ],
        ),
      ],
    );
  }
}

class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key, required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final reviews = _getReviews();

    return Column(
      children: [
        // Individual Reviews
        ...reviews
            .map(
              (review) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ReviewItem(review: review, isAr: isAr),
              ),
            )
            .toList(),
      ],
    );
  }

  List<Map<String, dynamic>> _getReviews() {
    return [
      {
        'name': 'Ahmed E.',
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
        'text': 'Very Useful And Great Pharmacy, They Have The Best Support Ever',
        'rating': 5,
      },
      {
        'name': 'Samar H.',
        'avatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100&h=100&fit=crop&crop=face',
        'text': 'An Exceptional Pharmacy With Outstanding Service. Their Team Is Always Ready To Assist With Any Inquiries.',
        'rating': 5,
      },
      {
        'name': 'Emad A.',
        'avatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face',
        'text': 'A Reliable Pharmacy That Truly Cares About Its Customers. Their Support Staff Is Knowledgeable',
        'rating': 4,
      },
    ];
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review, required this.isAr});

  final Map<String, dynamic> review;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Co.buttonGradient.withOpacityNew(0.3), width: 2),
          ),
          child: ClipOval(
            child: Image.network(
              review['avatar'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Co.buttonGradient.withOpacityNew(0.1),
                  child: const Icon(Icons.person, color: Co.buttonGradient, size: 20),
                );
              },
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Review Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(review['name'], style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold)),

              const SizedBox(height: 4),

              // Review Text
              Text(review['text'], style: TStyle.greyRegular(12).copyWith(height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}
