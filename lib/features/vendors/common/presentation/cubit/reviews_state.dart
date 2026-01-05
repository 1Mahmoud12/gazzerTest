import 'package:gazzer/features/vendors/common/domain/entities/review_entity.dart';

abstract class ReviewsState {
  const ReviewsState();
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

class ReviewsLoaded extends ReviewsState {
  final StoreReviewsEntity reviews;

  const ReviewsLoaded({required this.reviews});
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError({required this.message});
}
