import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepo _repo;
  LoginCubit(this._repo) : super(LoginInitialState());

  Future<void> login(String phone, String password) async {
    emit(LoginLoadingState());
    final res = await _repo.login(phone, password);
    switch (res) {
      case Ok<String> ok:
        emit(LoginSuccessState(ok.value));
        break;
      case Error err:
        emit(LoginErrorState(err.error.message ?? ''));
        break;
    }
  }
}
