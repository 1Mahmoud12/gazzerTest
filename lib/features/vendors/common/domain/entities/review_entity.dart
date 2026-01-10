class ReviewEntity {
  final int id;
  final int rating;
  final String? comment;
  final String clientName;
  final String? clientAvatar;
  final DateTime createdAt;

  const ReviewEntity({
    required this.id,
    required this.rating,
    this.comment,
    required this.clientName,
    this.clientAvatar,
    required this.createdAt,
  });
}

class StarBreakdownEntity {
  final int count;
  final int percentage;

  const StarBreakdownEntity({required this.count, required this.percentage});
}

class ReviewsStatisticsEntity {
  final double averageRating;
  final int totalReviews;
  final int recommendationPercentage;
  final Map<int, StarBreakdownEntity> starBreakdown;

  const ReviewsStatisticsEntity({
    required this.averageRating,
    required this.totalReviews,
    required this.recommendationPercentage,
    required this.starBreakdown,
  });
}

class StoreReviewsEntity {
  final int id;
  final String storeName;
  final String image;
  final double rate;
  final int rateCount;
  final List<ReviewEntity> reviews;
  final ReviewsStatisticsEntity reviewsStatistics;

  const StoreReviewsEntity({
    required this.id,
    required this.storeName,
    required this.image,
    required this.rate,
    required this.rateCount,
    required this.reviews,
    required this.reviewsStatistics,
  });
}
