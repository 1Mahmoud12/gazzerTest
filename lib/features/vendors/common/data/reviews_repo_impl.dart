import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/data/dtos/review_dto.dart';
import 'package:gazzer/features/vendors/common/domain/entities/review_entity.dart';
import 'package:gazzer/features/vendors/common/domain/reviews_repo.dart';

class ReviewsRepoImpl extends ReviewsRepo {
  final ApiClient _apiClient;

  ReviewsRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<StoreReviewsEntity>> getStoreReviews({required String storeType, required int storeId}) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.getStoreReviews(storeType, storeId)),
      parser: (response) {
        final responseDto = StoreReviewsResponseDto.fromJson(response.data);
        final entity = responseDto.toEntity();
        if (entity == null) {
          throw Exception('Failed to parse reviews data');
        }
        return entity;
      },
    );
  }
}
