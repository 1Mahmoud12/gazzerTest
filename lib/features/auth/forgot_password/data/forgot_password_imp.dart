import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/forgot_password/domain/forgot_password_repo.dart';

class ForgotPasswordImp extends ForgotPasswordRepo {
  final ApiClient _apiClient;

  ForgotPasswordImp(this._apiClient);
  late String phoneNum;
  late String resetPasswordToken;
  @override
  bool canChangePhone = false;

  @override
  Future<Result<String>> forgotPassword(String phoneNumber) async {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.forgetPassword, requestBody: {"phone": phoneNumber}),
      parser: (response) {
        phoneNum = phoneNumber;
        resetPasswordToken = '';
        return response.data['message'].toString();
      },
    );
  }

  @override
  Future<Result<String>> verifyOtp(String phoneNumber, String otp) async {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.forgetPasswordVerifyOTP,
        requestBody: {"phone": phoneNumber, "otp_code": otp},
      ),
      parser: (response) {
        resetPasswordToken = response.data['data']['reset_password_token'];
        return response.data['message'].toString();
      },
    );
  }

  @override
  Future<Result<String>> resetPassword(String newPassword) {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.resetPassword,
        requestBody: {
          "password_confirmation": newPassword,
          "password": newPassword,
          "reset_password_token": resetPasswordToken,
        },
      ),
      parser: (response) {
        return response.data['message'].toString();
      },
    );
  }

  ///
  @override
  Future<Result<String>> verify(String otpCode) => verifyOtp(phoneNum, otpCode);

  @override
  Future<Result<String>> resend() => forgotPassword(phoneNum);

  @override
  Future<Result<String>> onChangePhone(String newPhone) {
    throw UnimplementedError();
  }
}
