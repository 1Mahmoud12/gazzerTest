import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/crashlytics_repo_imp.dart';
import 'package:gazzer/core/data/repo/banner_repo_imp.dart';
import 'package:gazzer/core/domain/repos/banner_repo.dart';
import 'package:gazzer/core/domain/repos/crashlytics_repo.dart';
import 'package:gazzer/features/addresses/data/address_repo_imp.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/domain/address_repo.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/cubit/add_edit_address_cubit.dart';
import 'package:gazzer/features/auth/forgot_password/data/forgot_password_imp.dart';
import 'package:gazzer/features/auth/forgot_password/domain/forgot_password_repo.dart';
import 'package:gazzer/features/auth/login/data/login_repo_imp.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:gazzer/features/auth/register/data/register_repo_imp.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/cart/domain/cart_item_entity.dart';
import 'package:gazzer/features/favorites/data/favorites_repo_imp.dart';
import 'package:gazzer/features/favorites/domain/favorites_repo.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/home/main_home/data/home_repo_imp.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/profile/data/profile_repo_imp.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/splash/cubit/splash_cubit.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_cubit.dart';
import 'package:gazzer/features/vendors/resturants/data/repo_imp/plates_repo_imp.dart';
import 'package:gazzer/features/vendors/resturants/data/repo_imp/restaurants_repo_imp.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/plates_repo.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/cubit/restaurants_of_category_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/stores/data/repos/stores_repo_imp.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/cubit/product_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/stores_menu_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/cubit/stores_of_category_cubit.dart';
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
  /// register buses
  di.registerLazySingleton(() => FavoriteBus(di.get()));
  di.registerLazySingleton(() => AddressesBus(di.get()));

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
  di.registerLazySingleton<AddressRepo>(() => AddressRepoImp(di.get(), di.get()));
  di.registerLazySingleton<RegisterRepo>(() => RegisterRepoImp(di.get(), di.get()));
  di.registerLazySingleton<LoginRepo>(() => LoginRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ForgotPasswordRepo>(() => ForgotPasswordImp(di.get(), di.get()));
  di.registerLazySingleton<HomeRepo>(() => HomeRepoImp(di.get(), di.get()));
  di.registerLazySingleton<RestaurantsRepo>(() => RestaurantsRepoImp(di.get(), di.get()));
  di.registerLazySingleton<PlatesRepo>(() => PlatesRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ProfileRepo>(() => ProfileRepoImp(di.get(), di.get()));
  di.registerLazySingleton<BannerRepo>(() => BannerRepoImp(di.get(), di.get()));
  di.registerLazySingleton<StoresRepo>(() => StoresRepoImp(di.get(), di.get()));
  di.registerLazySingleton<FavoritesRepo>(() => FavoritesRepoImp(di.get(), di.get()));
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
  di.registerFactoryParam<SingleCatRestaurantCubit, int, int>(
    (id, plateId) => SingleCatRestaurantCubit(di.get(), id, plateId),
  );
  di.registerFactoryParam<StoresOfCategoryCubit, int, int>(
    (mainId, subCatId) => StoresOfCategoryCubit(di.get(), mainId, subCatId),
  );
  di.registerFactoryParam<StoreDetailsCubit, int, Null>((storeId, _) => StoreDetailsCubit(di.get(), storeId));
  di.registerFactoryParam<PlateDetailsCubit, int, Null>((plateId, _) => PlateDetailsCubit(di.get(), plateId));
  di.registerFactoryParam<ProductDetailsCubit, int, Null>((prodId, _) => ProductDetailsCubit(di.get(), prodId));
  di.registerFactoryParam<AddEditAddressCubit, AddressEntity?, Null>(
    (address, _) => AddEditAddressCubit(di.get(), oldAddress: address),
  );
  di.registerFactoryParam<AddToCartCubit, (GenericItemEntity, List<ItemOptionEntity>), CartItemEntity?>(
    (item, cartItem) => AddToCartCubit(item.$1, item.$2, cartItem),
  );
}
