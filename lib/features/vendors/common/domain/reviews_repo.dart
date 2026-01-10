import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/entities/review_entity.dart';

abstract class ReviewsRepo extends BaseApiRepo {
  ReviewsRepo(super.crashlyticsRepo);

  Future<Result<StoreReviewsEntity>> getStoreReviews({
    required String storeType,
    required int storeId,
  });
}
