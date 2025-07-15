import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';
import 'package:gazzer/features/splash/cubit/splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  final ProfileRepo _repo;
  SplashCubit(this._repo) : super(SplashInitial());

  Future<void> refreshToken() async {
    emit(SplashRefreshTokenLoading());
    final res = await _repo.refreshToken();
    switch (res) {
      case Ok<String> ok:
        emit(SplashRefreshTokenSuccess());
        break;
      case Err<String> err:
        emit(SplashRefreshTokenError(err.error.message));
        return;
    }
  }

  Future<void> getClient() async {
    emit(SplashGetClientLoading());
    final res = await _repo.getClient();
    switch (res) {
      case Ok<ClientEntity> ok:
        emit(SplashGetClientSuccess(ok.value));
        break;
      case Err<ClientEntity> err:
        emit(SplashGetClientError(err.error.message));
        return;
    }
  }
}
