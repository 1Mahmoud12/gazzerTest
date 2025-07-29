import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/crashlytics_repo_imp.dart';
import 'package:gazzer/core/data/repo/banner_repo_imp.dart';
import 'package:gazzer/core/domain/repos/banner_repo.dart';
import 'package:gazzer/core/domain/repos/crashlytics_repo.dart';
import 'package:gazzer/features/auth/forgot_password/data/forgot_password_imp.dart';
import 'package:gazzer/features/auth/forgot_password/domain/forgot_password_repo.dart';
import 'package:gazzer/features/auth/login/data/login_repo_imp.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:gazzer/features/auth/register/data/register_repo_imp.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/home/main_home/data/home_repo_imp.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/profile/data/profile_repo_imp.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/splash/cubit/splash_cubit.dart';
import 'package:gazzer/features/vendors/resturants/data/repo_imp/plates_repo_imp.dart';
import 'package:gazzer/features/vendors/resturants/data/repo_imp/restaurants_repo_imp.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/plates_repo.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/cubit/restaurants_of_category_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/stores/data/repos/stores_repo_imp.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';
import 'package:gazzer/features/vendors/stores/presentation/cubit/stores_menu_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/cubit/stores_of_category_cubit.dart';
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
  _registerRepos();

  ///
  _registerCubits();
}

Future _registerAsync() async {
  di.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  di.registerSingletonAsync<PackageInfo>(() => PackageInfo.fromPlatform());

  ///
  await Future.wait([di.getAsync<SharedPreferences>(), di.getAsync<PackageInfo>()]);
}

void _registerRepos() {
  di.registerLazySingleton<RegisterRepo>(() => RegisterRepoImp(di.get(), di.get()));
  di.registerLazySingleton<LoginRepo>(() => LoginRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ForgotPasswordRepo>(() => ForgotPasswordImp(di.get(), di.get()));
  di.registerLazySingleton<HomeRepo>(() => HomeRepoImp(di.get(), di.get()));
  di.registerLazySingleton<RestaurantsRepo>(() => RestaurantsRepoImp(di.get(), di.get()));
  di.registerLazySingleton<PlatesRepo>(() => PlatesRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ProfileRepo>(() => ProfileRepoImp(di.get(), di.get()));
  di.registerLazySingleton<BannerRepo>(() => BannerRepoImp(di.get(), di.get()));
  di.registerLazySingleton<StoresRepo>(() => StoresRepoImp(di.get(), di.get()));
}

void _registerCubits() {
  di.registerFactory(() => RegisterCubit(di.get()));
  di.registerFactory(() => LoginCubit(di.get()));
  di.registerFactory(() => HomeCubit(di.get()));
  di.registerFactory(() => RestaurantsMenuCubit(di.get(), di.get()));
  di.registerFactory(() => SplashCubit(di.get(), di.get()));
  di.registerFactory(() => ProfileCubit(di.get()));
  di.registerFactoryParam<RestaurantsOfCategoryCubit, int, Null>(
    (id, _) => RestaurantsOfCategoryCubit(di.get(), id),
  );
  di.registerFactoryParam<SingleRestaurantCubit, int, Null>(
    (id, _) => SingleRestaurantCubit(di.get(), id),
  );
  di.registerFactoryParam<StoresMenuCubit, int, Null>((id, _) => StoresMenuCubit(di.get(), id));
  di.registerFactoryParam<OrderedWithCubit, int, Null>((id, _) => OrderedWithCubit(di.get(), id));
  di.registerFactoryParam<StoresOfCategoryCubit, int, int>(
    (mainId, subCatId) => StoresOfCategoryCubit(di.get(), mainId, subCatId),
  );
}
