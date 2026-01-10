import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/requests/faq_rating_request.dart';
import 'package:gazzer/features/supportScreen/domain/faq_rating_repo.dart';

class FaqRatingRepoImp extends FaqRatingRepo {
  final ApiClient _apiClient;

  FaqRatingRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<String>> submitRating(FaqRatingRequest request) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.faqRating, requestBody: request.toJson()),
      parser: (response) => response.data['message']?.toString() ?? 'Rating submitted successfully',
    );
  }
}
