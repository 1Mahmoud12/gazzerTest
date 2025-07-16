import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/auth/common/data/client_response.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';

class LoginRepoImp extends LoginRepo {
  final ApiClient _apiClient;
  LoginRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<String>> login(String phone, String password) async {
    return super.call<String>(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.login,
        requestBody: {"phone": phone, "password": password},
      ),
      parser: (result) {
        final response = ClientResponse.fromWholeResponse(result.data);
        TokenService.setToken(response.accessToken);
        Session().setClient = response.toClientEntity();
        return response.message ?? '';
      },
    );
  }
}
