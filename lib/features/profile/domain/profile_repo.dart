import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/data/client_response.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/data/models/change_password_req.dart';
import 'package:gazzer/features/profile/data/models/delete_account_reason_dto.dart';
import 'package:gazzer/features/profile/data/models/delete_account_req.dart';
import 'package:gazzer/features/profile/data/models/profile_verify_otp_req.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';

abstract class ProfileRepo extends BaseApiRepo {
  ProfileRepo(super.crashlyticsRepo);

  Future<Result<String>> refreshToken();
  Future<Result<ClientEntity>> getClient();
  Future<Result<String>> logout();

  ///
  Future<Result<(ClientResponse?, String? sessionId)>> updateClient(UpdateProfileReq req);
  Future<Result<ClientResponse>> verifyOtp(ProfileVerifyOtpReq req);
  Future<Result<String>> changePassword(ChangePasswordReq req);

  /// ** delete account
  Future<Result<List<DeleteAccountReasonDTO>>> getDeleteAccountReasons();
  Future<Result<String>> requestDeleteAccount();
  Future<Result<String>> confirmDeleteAccount(DeleteAccountReq req);
}
