import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';
import 'package:gazzer/features/splash/cubit/splash_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashStates> {
  final ProfileRepo _repo;
  final SharedPreferences _prefs;
  SplashCubit(this._repo, this._prefs) : super(SplashInitial());

  Future<void> checkAuth() async {
    if (_prefs.getString(StorageKeys.token) != null) {
      return refreshToken();
    } else {
      if (_prefs.getBool(StorageKeys.haveSeenTour) != true) {
        emit(UnAuth(false));
      } else {
        emit(UnAuth(true));
      }
    }
  }

  Future<void> refreshToken() async {
    emit(RefreshTokenLoading());
    final res = await _repo.refreshToken();
    switch (res) {
      case Ok<String> ok:
        await _prefs.setString(StorageKeys.token, ok.value);
        emit(RefreshTokenSuccess());
        break;
      case Err<String> err:
        emit(RefreshTokenError(err.error.message));
        return;
    }
  }

  Future<void> getClient() async {
    emit(GetClientLoading());
    final res = await _repo.getClient();
    switch (res) {
      case Ok<ClientEntity> ok:
        Session().client = ok.value;
        emit(GetClientSuccess(ok.value));
        break;
      case Err<ClientEntity> err:
        emit(GetClientError(err.error.message));
        return;
    }
  }
}
