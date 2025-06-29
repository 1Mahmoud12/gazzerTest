import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/domain/entities/social_login_data.dart';
import 'package:gazzer/features/auth/domain/entities/user_entity.dart';
import 'package:gazzer/features/auth/domain/repos/sing_up_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpRepoImp extends SignUpRepo {
  final ApiClient apiClient;
  SignUpRepoImp(this.apiClient);

  @override
  Future<Result<SocialLoginData>> googleSingIn() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    await signIn.initialize();
    if (!signIn.supportsAuthenticate()) {
      return Result.error(ApiError(message: "asdad"));
    }
    try {
      final result = await signIn.authenticate();
      print(result.displayName);
      print(result.email);
      print(result.id);
      print(result.photoUrl);
      print(result.authentication.idToken);
      final data = SocialLoginData(id: result.id, email: result.email, photoUrl: result.photoUrl, name: result.displayName);
      return Result.ok(data);
    } catch (e) {
      return Result.error(ApiError(message: "Failed to sign in with Google: ${e.toString()}"));
    }
  }

  @override
  Future<Result<SocialLoginData>> appleSingIn() {
    // TODO: implement appleSingIn
    throw UnimplementedError();
  }

  @override
  Future<Result<SocialLoginData>> facebookSingIn() {
    // TODO: implement facebookSingIn
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity>> sendSocialToBackend(SocialLoginData data) async {
    print("sendin to back ....");
    await Future.delayed(Duration(seconds: 2));
    return Result.ok(UserEntity());
  }

  @override
  Future<Result<UserEntity>> singUp() {
    // TODO: implement singUp
    throw UnimplementedError();
  }
}
