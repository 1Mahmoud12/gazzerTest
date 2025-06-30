import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/domain/entities/social_login_data.dart';
import 'package:gazzer/features/auth/domain/entities/user_entity.dart';

enum Social { google, facebook, apple }

abstract class SignUpRepo {
  Future<Result<UserEntity>> singUp();
  Future<Result<SocialLoginData>> socialLogin(Social stype);
  Future<Result<UserEntity>> sendSocialToBackend(SocialLoginData data);
}
