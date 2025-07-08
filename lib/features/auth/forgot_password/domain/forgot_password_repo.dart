import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/verify/domain/verify_repo.dart';

abstract class ForgotPasswordRepo extends BaseApiRepo implements VerifyRepo {
  Future<Result<String>> forgotPassword(String phoneNumber);
  Future<Result<String>> verifyOtp(String phoneNumber, String otp);
  Future<Result<String>> resetPassword(String newPassword);
}
