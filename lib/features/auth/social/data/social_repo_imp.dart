import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/auth/social/domain/social_login_data.dart';
import 'package:gazzer/features/auth/social/domain/social_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialRepoImp extends SocialRepo {
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
      print("SOCIAL ::::: Error signing in with Google: $e");
      return Result.error(ApiError(message: "Failed to sign in with Google: ${e.toString()}"));
    }
  }

  Future<Result<SocialLoginData>> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      // or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        return Result.ok(
          SocialLoginData(
            id: result.accessToken?.tokenString ?? "**blank**",
            email: userData.entries.firstWhere((e) => e.key == 'email', orElse: () => const MapEntry('email', '**blank**')).value,
            name: userData.entries.firstWhere((e) => e.key == 'name', orElse: () => const MapEntry('name', '**blank**')).value,
            photoUrl: userData.entries
                .firstWhere(
                  (e) => e.key == 'picture',
                  orElse: () {
                    return const MapEntry('picture', {
                      'data': {'url': '**blank**'},
                    });
                  },
                )
                .value['data']['url'],
          ),
        );
      } else {
        return Result.error(ApiError(message: "Failed to sign in with Facebook: ${result.message ?? 'Unknown error'}"));
      }
    } catch (e) {
      print("SOCIAL ::::: Error signing in with Facebook: $e");
      return Result.error(ApiError(message: "Failed to sign in with Facebook: ${e.toString()}"));
    }
  }

  Future<Result<SocialLoginData>> _signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);
      return Result.ok(
        SocialLoginData(
          id: credential.userIdentifier ?? '**blank**',
          email: credential.email,
          name: "${credential.givenName ?? ''} ${credential.familyName ?? ''}",
          idToken: credential.identityToken,
        ),
      );
    } catch (e) {
      print("SOCIAL ::::: Error signing in with APple: $e");
      return Result.error(ApiError(message: "Failed to sign in with Apple: ${e.toString()}"));
    }
  }

  @override
  Future<Result<ClientEntity>> sendSocialToBackend(SocialLoginData data) async {
    print("sendin to back ....");
    await Future.delayed(const Duration(seconds: 2));
    return Result.ok(ClientEntity());
  }
}
