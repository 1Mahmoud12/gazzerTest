sealed class LoginStates {}

final class LoginInitialState extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginSuccessState extends LoginStates {
  final String message;

  LoginSuccessState(this.message);
}

final class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
