import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/common/domain/entities/review_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/reviews_cubit.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/reviews_state.dart';
import 'package:intl/intl.dart';

class StoreReviewsScreen extends StatefulWidget {
  const StoreReviewsScreen({super.key, required this.storeType, required this.storeId});

  final String storeType;
  final int storeId;

  static const route = '/store-reviews';

  @override
  State<StoreReviewsScreen> createState() => _StoreReviewsScreenState();
}

class _StoreReviewsScreenState extends State<StoreReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsCubit(di.get())..loadReviews(storeType: widget.storeType, storeId: widget.storeId),
      child: Scaffold(
        backgroundColor: Co.white,
        appBar: MainAppBar(title: L10n.tr().ratings_reviews),
        body: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            if (state is ReviewsLoading) {
              return const Center(child: AdaptiveProgressIndicator());
            }

            if (state is ReviewsError) {
              return FailureComponent(
                message: state.message,
                onRetry: () {
                  context.read<ReviewsCubit>().loadReviews(storeType: widget.storeType, storeId: widget.storeId);
                },
              );
            }

            if (state is ReviewsLoaded) {
              final reviews = state.reviews;
              final statistics = reviews.reviewsStatistics;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating Summary
                    _RatingSummarySection(statistics: statistics),
                    const VerticalSpacing(16),

                    // Star Breakdown
                    _StarBreakdownSection(starBreakdown: statistics.starBreakdown),
                    //  const VerticalSpacing(16),

                    // Reviews List
                    Text('${statistics.totalReviews} ${L10n.tr().reviews}', style: TStyle.robotBlackSubTitle()),
                    const VerticalSpacing(16),
                    ...reviews.reviews.map((review) => _ReviewCard(review: review)),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _RatingSummarySection extends StatelessWidget {
  const _RatingSummarySection({required this.statistics});

  final ReviewsStatisticsEntity statistics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Star Ratings Bars
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StarRatingBar(starNumber: 5, breakdown: statistics.starBreakdown[5]),
              const VerticalSpacing(8),
              _StarRatingBar(starNumber: 4, breakdown: statistics.starBreakdown[4]),
              const VerticalSpacing(8),
              _StarRatingBar(starNumber: 3, breakdown: statistics.starBreakdown[3]),
              const VerticalSpacing(8),
              _StarRatingBar(starNumber: 2, breakdown: statistics.starBreakdown[2]),
              const VerticalSpacing(8),
              _StarRatingBar(starNumber: 1, breakdown: statistics.starBreakdown[1]),
            ],
          ),
        ),
        const HorizontalSpacing(16),
        // Average Rating
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(statistics.averageRating.toStringAsFixed(1), style: TStyle.robotBlackTitle()),
                const HorizontalSpacing(8),
                const Padding(padding: EdgeInsets.only(bottom: 8), child: VectorGraphicsWidget(Assets.starRateIc, width: 22, height: 22)),
              ],
            ),
            Text('${statistics.totalReviews} ${L10n.tr().reviews}', style: TStyle.robotBlackRegular14().copyWith(color: Co.darkGrey)),
            const VerticalSpacing(16),
            Text('${statistics.recommendationPercentage}%', style: TStyle.robotBlackTitle()),
            Text(L10n.tr().recommended, style: TStyle.robotBlackRegular14().copyWith(color: Co.darkGrey)),
          ],
        ),
      ],
    );
  }
}

class _StarRatingBar extends StatelessWidget {
  const _StarRatingBar({required this.starNumber, required this.breakdown});

  final int starNumber;
  final StarBreakdownEntity? breakdown;

  @override
  Widget build(BuildContext context) {
    final percentage = breakdown?.percentage ?? 0;

    return Row(
      children: [
        Text('$starNumber ${L10n.tr().star}', style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey)),
        const HorizontalSpacing(8),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(color: Co.lightGrey, borderRadius: BorderRadius.circular(4)),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ],
          ),
        ),
        const HorizontalSpacing(4),
        SizedBox(
          width: 35,
          child: Text(
            '$percentage%',
            style: TStyle.robotBlackRegular14().copyWith(color: Co.darkGrey),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StarBreakdownSection extends StatelessWidget {
  const _StarBreakdownSection({required this.starBreakdown});

  final Map<int, StarBreakdownEntity> starBreakdown;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final ReviewEntity review;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d, yyyy', L10n.isAr(context) ? 'ar' : 'en');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          ClipOval(
            child: review.clientAvatar != null
                ? CustomNetworkImage(review.clientAvatar!, width: 50, height: 50, fit: BoxFit.cover)
                : Container(
                    width: 50,
                    height: 50,
                    color: Co.secondary,
                    child: Center(
                      child: Text(
                        review.clientName.isNotEmpty ? review.clientName.substring(0, 1).toUpperCase() : 'C',
                        style: TStyle.robotBlackSubTitle(),
                      ),
                    ),
                  ),
          ),
          const HorizontalSpacing(12),
          // Review Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.clientName, style: TStyle.robotBlackMedium()),
                const VerticalSpacing(8),
                // Stars
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 4,
                        children: List.generate(
                          5,
                          (index) => VectorGraphicsWidget(index < review.rating ? Assets.starRateIc : Assets.starNotRateIc, width: 20, height: 20),
                        ),
                      ),
                    ),
                    Text(dateFormat.format(review.createdAt), style: TStyle.robotBlackThin()),
                  ],
                ),
                if (review.comment != null && review.comment!.isNotEmpty) ...[
                  const VerticalSpacing(8),
                  Text(review.comment!, style: TStyle.robotBlackRegular()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
