import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/entities/review_entity.dart';
import 'package:gazzer/features/vendors/common/domain/reviews_repo.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this._repo) : super(const ReviewsInitial());

  final ReviewsRepo _repo;

  Future<void> loadReviews({
    required String storeType,
    required int storeId,
  }) async {
    emit(const ReviewsLoading());

    final result = await _repo.getStoreReviews(
      storeType: storeType,
      storeId: storeId,
    );

    switch (result) {
      case Ok<StoreReviewsEntity>(:final value):
        emit(ReviewsLoaded(reviews: value));
      case Err<StoreReviewsEntity>(:final error):
        emit(ReviewsError(message: error.message));
    }
  }
}
