import 'package:gazzer/features/vendors/common/domain/entities/review_entity.dart';

class ReviewDto {
  final int? id;
  final int? rating;
  final String? comment;
  final String? clientName;
  final String? clientAvatar;
  final String? createdAt;

  ReviewDto({this.id, this.rating, this.comment, this.clientName, this.clientAvatar, this.createdAt});

  factory ReviewDto.fromJson(Map<String, dynamic> json) {
    return ReviewDto(
      id: json['id'] as int?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      clientName: json['client_name'] as String?,
      clientAvatar: json['client_avatar'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  ReviewEntity toEntity() {
    DateTime parsedDate = DateTime.now();
    if (createdAt != null) {
      try {
        parsedDate = DateTime.parse(createdAt!);
      } catch (e) {
        parsedDate = DateTime.now();
      }
    }

    return ReviewEntity(
      id: id ?? 0,
      rating: rating ?? 0,
      comment: comment,
      clientName: clientName ?? 'Unknown',
      clientAvatar: clientAvatar,
      createdAt: parsedDate,
    );
  }
}

class StarBreakdownDto {
  final int? count;
  final int? percentage;

  StarBreakdownDto({this.count, this.percentage});

  factory StarBreakdownDto.fromJson(Map<String, dynamic> json) {
    return StarBreakdownDto(count: json['count'] as int?, percentage: json['percentage'] as int?);
  }

  StarBreakdownEntity toEntity() {
    return StarBreakdownEntity(count: count ?? 0, percentage: percentage ?? 0);
  }
}

class ReviewsStatisticsDto {
  final double? averageRating;
  final int? totalReviews;
  final int? recommendationPercentage;
  final Map<String, dynamic>? starBreakdown;

  ReviewsStatisticsDto({this.averageRating, this.totalReviews, this.recommendationPercentage, this.starBreakdown});

  factory ReviewsStatisticsDto.fromJson(Map<String, dynamic> json) {
    return ReviewsStatisticsDto(
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      totalReviews: json['total_reviews'] as int?,
      recommendationPercentage: json['recommendation_percentage'] as int?,
      starBreakdown: json['star_breakdown'] as Map<String, dynamic>?,
    );
  }

  ReviewsStatisticsEntity toEntity() {
    final Map<int, StarBreakdownEntity> breakdown = {};

    if (starBreakdown != null) {
      starBreakdown!.forEach((key, value) {
        final starNumber = int.tryParse(key.replaceAll('_star', ''));
        if (starNumber != null && value is Map<String, dynamic>) {
          breakdown[starNumber] = StarBreakdownDto.fromJson(value).toEntity();
        }
      });
    }

    return ReviewsStatisticsEntity(
      averageRating: averageRating ?? 0.0,
      totalReviews: totalReviews ?? 0,
      recommendationPercentage: recommendationPercentage ?? 0,
      starBreakdown: breakdown,
    );
  }
}

class StoreReviewsDto {
  final int? id;
  final String? storeName;
  final String? image;
  final String? rate;
  final int? rateCount;
  final List<dynamic>? reviews;
  final Map<String, dynamic>? reviewsStatistics;

  StoreReviewsDto({this.id, this.storeName, this.image, this.rate, this.rateCount, this.reviews, this.reviewsStatistics});

  factory StoreReviewsDto.fromJson(Map<String, dynamic> json) {
    return StoreReviewsDto(
      id: json['id'] as int?,
      storeName: json['store_name'] as String?,
      image: json['image'] as String?,
      rate: json['rate'] as String?,
      rateCount: json['rate_count'] as int?,
      reviews: json['reviews'] as List<dynamic>?,
      reviewsStatistics: json['reviews_statistics'] as Map<String, dynamic>?,
    );
  }

  StoreReviewsEntity toEntity() {
    final reviewsList =
        reviews?.map((review) {
          if (review is Map<String, dynamic>) {
            return ReviewDto.fromJson(review).toEntity();
          }
          return ReviewEntity(id: 0, rating: 0, clientName: 'Unknown', createdAt: DateTime.now());
        }).toList() ??
        [];

    final statistics = reviewsStatistics != null
        ? ReviewsStatisticsDto.fromJson(reviewsStatistics!).toEntity()
        : const ReviewsStatisticsEntity(averageRating: 0.0, totalReviews: 0, recommendationPercentage: 0, starBreakdown: {});

    return StoreReviewsEntity(
      id: id ?? 0,
      storeName: storeName ?? '',
      image: image ?? '',
      rate: double.tryParse(rate ?? '0') ?? 0.0,
      rateCount: rateCount ?? 0,
      reviews: reviewsList,
      reviewsStatistics: statistics,
    );
  }
}

class StoreReviewsResponseDto {
  final String? status;
  final String? message;
  final Map<String, dynamic>? data;

  StoreReviewsResponseDto({this.status, this.message, this.data});

  factory StoreReviewsResponseDto.fromJson(Map<String, dynamic> json) {
    return StoreReviewsResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  StoreReviewsEntity? toEntity() {
    if (data == null) return null;
    return StoreReviewsDto.fromJson(data!).toEntity();
  }
}
