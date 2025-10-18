import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';
import 'package:gazzer/features/auth/common/data/client_response.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/register/data/check_phone_email_dto.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';

class RegisterRepoImp extends RegisterRepo {
  final ApiClient _apiClient;
  RegisterRepoImp(this._apiClient, super.crashlyticsRepo);

  // late String _sessionId;

  @override
  Future<Result<CheckPhoneEmailData>> checkPhoneEmail(
    String phone,
    String? email,
  ) {
    return call<CheckPhoneEmailData>(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.checkPhoneEmail,
        requestBody: {
          'phone': phone,
          if (email != null && email.isNotEmpty) 'email': email,
        },
      ),
      parser: (result) {
        final dto = CheckPhoneEmailDto.fromJson(result.data);
        return dto.data ?? CheckPhoneEmailData(phoneFound: false, emailFound: false);
      },
    );
  }

  @override
  Future<Result<AuthResponse>> register(RegisterRequest req) {
    return call<AuthResponse>(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.register,
        requestBody: req.toJson(),
      ),
      parser: (result) {
        return AuthResponse.fromJson(result.data);
      },
    );
  }

  @override
  Future<Result<String>> resendOtp(String sessionId) {
    return call<String>(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.resendOtp,
        requestBody: {'session_id': sessionId},
      ),
      parser: (result) {
        return result.data['message']?.toString() ?? 'Success';
      },
    );
  }

  /// data is sessionId
  @override
  Future<Result<String>> resend(dynamic data) => resendOtp(data);

  @override
  Future<Result<String>> editPhoneNumber(String sessionId, String code) {
    return call<String>(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.editPhoneNum,
        requestBody: {'phone': code, 'session_id': sessionId},
      ),
      parser: (result) {
        return result.data['message']?.toString() ?? 'Success';
      },
    );
  }

  @override
  Future<Result<String>> onChangePhone(String newPhone, String data) => editPhoneNumber(data, newPhone);

  @override
  Future<Result<String>> verifyOTP(String sessionId, String code) {
    final body = {'session_id': sessionId, 'otp_code': code};
    return call<String>(
      apiCall: () => _apiClient.post(endpoint: Endpoints.verifyOTP, requestBody: body),
      parser: (result) {
        final response = ClientResponse.fromWholeResponse(result.data);
        setAuthUser(response.toClientEntity(), response.accessToken);
        return response.message ?? 'Success';
      },
    );
  }

  /// data is sessionId
  @override
  Future<Result<String>> verify(String otpCode, dynamic data) => verifyOTP(data, otpCode);

  @override
  void setAuthUser(ClientEntity client, String token) {
    TokenService.setToken(token);
    Session().setClient = client;
  }

  @override
  bool canChangePhone = true;
}
