import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/crashlytics_repo_imp.dart';
import 'package:gazzer/core/domain/crashlytics_repo.dart';
import 'package:gazzer/features/auth/forget_password/data/forgot_password_imp.dart';
import 'package:gazzer/features/auth/forget_password/domain/forgot_password_repo.dart';
import 'package:gazzer/features/auth/login/data/login_repo_imp.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:gazzer/features/auth/register/data/register_repo_imp.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future init() async {
  ///
  await _registerAsync();

  ///
  di.registerSingleton<ApiClient>(ApiClient());
  di.registerSingleton<CrashlyticsRepo>(CrashlyticsRepoImp());
  _registerRepos(di.get<ApiClient>());

  ///
  _registerCubits();
}

Future _registerAsync() async {
  di.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  di.registerSingletonAsync<PackageInfo>(() => PackageInfo.fromPlatform());

  ///
  await Future.wait([di.getAsync<SharedPreferences>(), di.getAsync<PackageInfo>()]);
}

void _registerRepos(ApiClient apiClient) {
  di.registerLazySingleton<RegisterRepo>(() => RegisterRepoImp(apiClient));
  di.registerLazySingleton<LoginRepo>(() => LoginRepoImp(apiClient));
  di.registerLazySingleton<ForgotPasswordRepo>(() => ForgotPasswordImp(apiClient));
}

void _registerCubits() {
  di.registerFactory(() => RegisterCubit(di.get()));
  di.registerFactory(() => LoginCubit(di.get()));
}
