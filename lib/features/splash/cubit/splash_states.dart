import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';

sealed class SplashStates {}

class SplashInitial extends SplashStates {}

sealed class SplashRefreshTokenStates extends SplashStates {}

class SplashRefreshTokenLoading extends SplashRefreshTokenStates {}

class SplashRefreshTokenSuccess extends SplashRefreshTokenStates {}

class SplashRefreshTokenError extends SplashRefreshTokenStates {
  final String message;

  SplashRefreshTokenError(this.message);
}

sealed class SplashGetClientStates extends SplashStates {}

class SplashGetClientLoading extends SplashGetClientStates {}

class SplashGetClientSuccess extends SplashGetClientStates {
  final ClientEntity client;
  SplashGetClientSuccess(this.client);
}

class SplashGetClientError extends SplashGetClientStates {
  final String message;
  SplashGetClientError(this.message);
}
