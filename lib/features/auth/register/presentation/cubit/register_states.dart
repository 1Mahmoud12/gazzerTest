import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';

abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {
  final AuthResponse resp;

  RegisterSuccess(this.resp);
}

class RegisterError extends RegisterStates {
  final ApiError error;

  RegisterError(this.error);
}
