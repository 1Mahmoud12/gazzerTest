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
  Future<Result<SocialLoginData>> socialLogin(Social type) async {
    switch (type) {
      case Social.google:
        return await _signInWithGoogle();
      case Social.facebook:
        return await _signInWithFacebook();
      case Social.apple:
        return await _signInWithApple();
    }
  }

  Future<Result<SocialLoginData>> _signInWithGoogle() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    await signIn.initialize();
    if (!signIn.supportsAuthenticate()) {
      return Result.error(ApiError(message: "asdad"));
    }
    try {
      final result = await signIn.authenticate();
      final data = SocialLoginData(
        id: result.id,
        email: result.email,
        photoUrl: result.photoUrl,
        name: result.displayName,
        idToken: result.authentication.idToken,
      );
      return Result.ok(data);
    } catch (e) {
      return Result.error(ApiError(message: "Failed to sign in with Google: ${e.toString()}"));
    }
  }

  Future<Result<SocialLoginData>> _signInWithFacebook() async {
    // Implement Facebook sign-in logic here
    await Future.delayed(Duration(seconds: 2));
    return Result.ok(SocialLoginData(id: "facebook_id", email: "facebook_email", photoUrl: "facebook_photo_url", name: "facebook_name"));
  }

  Future<Result<SocialLoginData>> _signInWithApple() async {
    // Implement Apple sign-in logic here
    await Future.delayed(Duration(seconds: 2));
    return Result.ok(SocialLoginData(id: "apple_id", email: "apple_email", photoUrl: "apple_photo_url", name: "apple_name"));
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
