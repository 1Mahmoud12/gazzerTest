import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/domain/entities/social_login_data.dart';
import 'package:gazzer/features/auth/domain/entities/user_entity.dart';
import 'package:gazzer/features/auth/domain/repos/sing_up_repo.dart';

class SocialLogin {
  SignUpRepo repo;
  SocialLogin(this.repo);

  Future<Result<UserEntity>> excute(Social type) async {
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
