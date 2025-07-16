import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/data/client_response.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/data/models/change_password_req.dart';
import 'package:gazzer/features/profile/data/models/delete_account_reason.dart';
import 'package:gazzer/features/profile/data/models/delete_account_req.dart';
import 'package:gazzer/features/profile/data/models/profile_verify_otp_req.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';

class ProfileRepoImp extends ProfileRepo {
  final ApiClient _apiClient;

  ProfileRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<(ClientResponse?, String?)>> updateClient(UpdateProfileReq req) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.updateProfile, requestBody: req.toJson()),
      parser: (response) {
        final Map<String, dynamic> data = response.data['data'];
        if (data.containsKey('session_id')) {
          return (null, data['session_id'].toString());
        } else if (data.containsKey('access_token')) {
          return (ClientResponse.fromWholeResponse(response.data), null);
        } else {
          throw Exception('Unexpected response format');
        }
      },
    );
  }

  @override
  Future<Result<ClientResponse>> verifyOtp(ProfileVerifyOtpReq req) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.verifyProfileUpdate, requestBody: req.toJson()),
      parser: (response) {
        return ClientResponse.fromWholeResponse(response.data);
      },
    );
  }

  @override
  Future<Result<String>> changePassword(ChangePasswordReq req) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.changePassword, requestBody: req.toJson()),
      parser: (response) {
        return response.data['message'].toString();
      },
    );
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

  @override
  Future<Result<ClientEntity>> getClient() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.profile),
      parser: (response) {
        return ClientDTO.fromJson(response.data['data']).toClientEntity();
      },
    );
  }

  @override
  Future<Result<String>> confirmDeleteAccount(DeleteAccountReq req) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.confirmDeleteAccount, requestBody: req.toJson()),
      parser: (response) {
        return response.data['message'].toString();
      },
    );
  }

  @override
  Future<Result<String>> requestDeleteAccount() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.requestDeleteAccount),
      parser: (response) {
        return response.data['data']['session_id'].toString();
      },
    );
  }

  @override
  Future<Result<List<DeleteAccountReason>>> getDeleteAccountReasons() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.deleteAccountReasons),
      parser: (response) {
        return (response.data['data'] as List).map((e) => DeleteAccountReason.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Result<String>> logout() {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.logout, requestBody: null),
      parser: (response) {
        return response.data['message'].toString();
      },
    );
  }
}
