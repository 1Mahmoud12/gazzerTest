import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/social/domain/social_login_data.dart';

enum Social { google, facebook, apple }

abstract class SocialRepo {
  Future<Result<SocialLoginData>> socialLogin(Social stype);
  Future<Result<ClientEntity>> sendSocialToBackend(SocialLoginData data);
}
