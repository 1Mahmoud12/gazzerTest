import 'package:gazzer/core/data/local_storage/storage_keys.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/domain/crashlytics_repo.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login/login_cubit_test.mocks.dart';
import 'auth/register/register_cubit_test.mocks.dart';
import 'core/core_generator.mocks.dart';

final diTest = GetIt.instance;

Future initTest() async {
  /// initialization
  /// core
  diTest.registerSingleton<SharedPreferences>(MockSharedPreferences());
  defineSharedPreMockfMethods();
  diTest.registerSingleton<ApiClient>(MockApiClient());
  diTest.registerSingleton<CrashlyticsRepo>(MockCrashlyticsRepoImp());

  ///
  _registerMockRepos();
}

/// Register repositories.
void _registerMockRepos() {
  diTest.registerLazySingleton<RegisterRepo>(() => MockRegisterRepoImp());
  diTest.registerLazySingleton<LoginRepo>(() => MockLoginRepoImp());
}

/// Define methods for SharedPreferences to mock their behavior.
void defineSharedPreMockfMethods() {
  final prefs = diTest.get<SharedPreferences>();
  when(
    prefs.setString(StorageKeys.token, StorageKeys.token),
  ).thenAnswer((_) async => true);
  when(
    prefs.getString(StorageKeys.token),
  ).thenAnswer((_) => StorageKeys.token);
  when(
    prefs.remove(StorageKeys.token),
  ).thenAnswer((_) async => true);
}
