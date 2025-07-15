import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/data/client_response.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';

class ProfileRepoImp extends ProfileRepo {
  final ApiClient _apiClient;
  ProfileRepoImp(this._apiClient);
  @override
  Future<Result<ClientEntity>> getClient() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.profile),
      parser: (response) {
        return ClientDTO.fromJson(response.data).toClientEntity();
      },
    );
  }

  @override
  Future<Result<String>> changePassword(ClientEntity client) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Result<(ClientEntity, String)>> updateClient(ClientEntity client) {
    // TODO: implement updateClient
    throw UnimplementedError();
  }

  @override
  Future<Result<ClientEntity>> verifyOtp(ClientEntity client) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> refreshToken() {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.refreshToken, requestBody: null),
      parser: (response) {
        return response.data['data']['access_token'].toString();
      },
    );
  }
}
