import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/register/data/check_phone_email_dto.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/verify/domain/verify_repo.dart';

abstract class RegisterRepo extends BaseApiRepo implements VerifyRepo {
  RegisterRepo(super.crashlyticsRepo);

  // register
  Future<Result<CheckPhoneEmailData>> checkPhoneEmail(String phone, String? email);
  Future<Result<AuthResponse>> register(RegisterRequest req);
  Future<Result<String>> verifyOTP(String sessionId, String code);
  Future<Result<String>> resendOtp(String sessionId);
  Future<Result<String>> editPhoneNumber(String sessionId, String code);

  Future<Result<String>> validateReferralCode(String referralCode);
  void setAuthUser(ClientEntity client, String token);
}
