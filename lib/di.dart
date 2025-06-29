import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/features/auth/data/repos/sign_up_repo_imp.dart';
import 'package:gazzer/features/auth/domain/repos/sing_up_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future init() async {
  await _registerAsync();
  final apiClient = ApiClient();

  ///
  ///Repos
  di.registerLazySingleton<SignUpRepo>(() => SignUpRepoImp(apiClient));

  ///
  /// cubits
}

Future _registerAsync() async {
  di.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  di.registerSingletonAsync<PackageInfo>(() => PackageInfo.fromPlatform());

  ///
  await Future.wait([di.getAsync<SharedPreferences>(), di.getAsync<PackageInfo>()]);
}
