import 'package:gazzer/core/data/local_storage/storage_keys.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/domain/crashlytics_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core_generator.mocks.dart';

final di = GetIt.instance;

Future initTest() async {
  /// initialization
  di.registerSingleton<SharedPreferences>(MockSharedPreferences());
  defineSharedPreMockfMethods();

  ///
  di.registerSingleton<ApiClient>(MockApiClient());
  di.registerSingleton<CrashlyticsRepo>(MockCrashlyticsRepoImp());
  _registerRepos(di.get<ApiClient>(), di.get<CrashlyticsRepo>());

  ///
  _registerCubits();
}

/// Register repositories with the dependency injection container.
void _registerRepos(ApiClient apiClient, CrashlyticsRepo crashlyticsRepo) {
  // di.registerLazySingleton<RegisterRepo>(() => MockRegisterRepoImp(apiClient, crashlyticsRepo));
}

/// Register cubits with the dependency injection container.
void _registerCubits() {
  // di.registerFactory(() => RegisterCubit(di.get()));
}

/// Define methods for SharedPreferences to mock their behavior.
void defineSharedPreMockfMethods() {
  final prefs = di.get<SharedPreferences>();
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
