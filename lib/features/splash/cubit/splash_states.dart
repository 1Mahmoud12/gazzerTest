import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';

sealed class SplashStates {}

class SplashInitial extends SplashStates {}

sealed class RefreshTokenStates extends SplashStates {}

class RefreshTokenLoading extends RefreshTokenStates {}

class RefreshTokenSuccess extends RefreshTokenStates {}

class RefreshTokenError extends RefreshTokenStates {
  final String message;

  RefreshTokenError(this.message);
}

sealed class GetClientStates extends SplashStates {}

class GetClientLoading extends GetClientStates {}

class GetClientSuccess extends GetClientStates {
  final ClientEntity client;
  GetClientSuccess(this.client);
}

class GetClientError extends GetClientStates {
  final String message;
  GetClientError(this.message);
}

class UnAuth extends SplashStates {
  final bool haveSeenTour;
  UnAuth(this.haveSeenTour);
}
