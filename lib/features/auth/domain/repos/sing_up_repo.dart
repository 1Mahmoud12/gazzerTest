import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/domain/entities/social_login_data.dart';
import 'package:gazzer/features/auth/domain/entities/user_entity.dart';

abstract class SignUpRepo {
  Future<Result<UserEntity>> singUp();
  Future<Result<SocialLoginData>> googleSingIn();
  Future<Result<SocialLoginData>> facebookSingIn();
  Future<Result<SocialLoginData>> appleSingIn();
  Future<Result<UserEntity>> sendSocialToBackend(SocialLoginData data);
}
