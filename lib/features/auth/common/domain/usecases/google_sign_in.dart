import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/common/social/domain/social_login_data.dart';
import 'package:gazzer/features/auth/common/social/domain/social_repo.dart';

class SocialLogin {
  SocialRepo repo;
  SocialLogin(this.repo);

  Future<Result<ClientEntity>> excute(Social type) async {
    try {
      final result = await repo.socialLogin(type);
      switch (result) {
        case Ok<SocialLoginData> ok:
          return await repo.sendSocialToBackend(ok.value);
        case Error<ApiError> e:
          return Result.error(e.error);
        default:
          return Result.error(ApiError(message: "Unknown error occurred"));
      }
    } catch (e) {
      return Result.error(ApiError(message: "Unknown error occurred"));
    }
  }
}
