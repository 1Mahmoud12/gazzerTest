import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';

sealed class RegisterStates {}

final class RegisterInitial extends RegisterStates {}

final class RegisterLoading extends RegisterStates {}

final class RegisterSuccess extends RegisterStates {
  final AuthResponse resp;

  RegisterSuccess(this.resp);
}

final class RegisterError extends RegisterStates {
  final BaseError error;

  RegisterError(this.error);
}
