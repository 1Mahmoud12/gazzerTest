import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/share/data/share_models.dart';
import 'package:gazzer/features/share/domain/share_repo.dart';

class ShareRepoImp extends ShareRepo {
  final ApiClient _apiClient;

  ShareRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<ShareGenerateResponse>> generateShareLink(ShareGenerateRequest request) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.generateShareLink, requestBody: request.toJson()),
      parser: (response) {
        return ShareGenerateResponse.fromJson(response.data['data'] as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Result<ShareOpenResponse>> openShareLink(String token) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: '${Endpoints.openShareLink}?token=$token', requestBody: {}),
      parser: (response) {
        return ShareOpenResponse.fromJson(response.data['data'] as Map<String, dynamic>);
      },
    );
  }
}
