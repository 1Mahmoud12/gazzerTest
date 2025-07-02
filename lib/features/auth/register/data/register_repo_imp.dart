import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';
import 'package:gazzer/features/auth/common/data/client_response.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';

class RegisterRepoImp extends RegisterRepo {
  final ApiClient _apiClient;
  RegisterRepoImp(this._apiClient);

  late final String _sessionId;

  @override
  Future<Result<String>> editPhoneNumber(String sessionId, String code) {
    return call<String>(
      apiCall: () => _apiClient.post(endpoint: Endpoints.editPhoneNum(sessionId), requestBody: {'otp_code': code}),
      parser: (result) {
        return result.data['message']?.toString() ?? 'Success';
      },
    );
  }

  @override
  Future<Result<AuthResponse>> register(RegisterRequest req) {
    return call<AuthResponse>(
      apiCall: () => _apiClient.post(endpoint: Endpoints.register, requestBody: req.toJson()),
      parser: (result) {
        final resp = AuthResponse.fromJson(result.data);
        _sessionId = resp.sessionId;
        return resp;
      },
    );
  }

  @override
  Future<Result<String>> resend() {
    return resendOtp(_sessionId);
  }

  @override
  Future<Result<String>> resendOtp(String sessionId) {
    return call<String>(
      apiCall: () => _apiClient.post(endpoint: Endpoints.resendOtp(sessionId), requestBody: {}),
      parser: (result) {
        return result.data['message']?.toString() ?? 'Success';
      },
    );
  }

  @override
  Future<Result<String>> verify(String otpCode) {
    return verifyOTP(_sessionId, otpCode);
  }

  @override
  Future<Result<String>> verifyOTP(String sessionId, String code) {
    final body = {'session_id': sessionId, 'otp_code': code};
    return call<String>(
      apiCall: () => _apiClient.post(endpoint: Endpoints.verifyOTP, requestBody: body),
      parser: (result) {
        final response = ClientResponse.fromJson(result.data);
        setAuthUser(response.client, response.accessToken);
        return response.message ?? 'Success';
      },
    );
  }

  @override
  void setAuthUser(ClientEntity client, String token) {
    TokenService.setToken(token);
    Session().setClient = client;
  }
}
