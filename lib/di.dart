import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'package:gazzer/features/cart/data/cart_repo_imp.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/checkout/data/checkout_repo_imp.dart';
import 'package:gazzer/features/checkout/domain/checkout_repo.dart';
import 'package:gazzer/features/checkout/presentation/cubit/cardsCubit/cards_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_cubit.dart';
import 'package:gazzer/features/dailyOffers/data/daily_offer_repo_imp.dart';
import 'package:gazzer/features/dailyOffers/domain/daily_offer_repo.dart';
import 'package:gazzer/features/dailyOffers/presentation/cubit/daily_offer_cubit.dart';
import 'package:gazzer/features/favorites/data/favorites_repo_imp.dart';
import 'package:gazzer/features/favorites/domain/favorites_repo.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/home/best_popular/data/repositories/best_popular_repository_impl.dart';
import 'package:gazzer/features/home/best_popular/domain/repositories/best_popular_repository.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_cubit.dart';
import 'package:gazzer/features/home/home_categories/popular/data/top_items_repo_impl.dart';
import 'package:gazzer/features/home/home_categories/popular/domain/top_items_repo.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/cubit/top_items_cubit.dart';
import 'package:gazzer/features/home/home_categories/suggested/data/suggests_repo_impl.dart';
import 'package:gazzer/features/home/home_categories/suggested/domain/suggests_repo.dart';
import 'package:gazzer/features/home/home_categories/suggested/presentation/cubit/suggests_cubit.dart';
import 'package:gazzer/features/home/main_home/data/home_repo_imp.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/top_vendors/data/top_vendors_repo_imp.dart';
import 'package:gazzer/features/home/top_vendors/domain/top_vendors_repo.dart';
import 'package:gazzer/features/home/top_vendors/presentation/cubit/top_vendors_cubit.dart';
import 'package:gazzer/features/loyaltyProgram/data/loyalty_program_repo_impl.dart';
import 'package:gazzer/features/loyaltyProgram/domain/loyalty_program_repo.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/cubit/loyalty_program_cubit.dart';
import 'package:gazzer/features/profile/data/profile_repo_imp.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/search/data/search_repo_imp.dart';
import 'package:gazzer/features/search/domain/search_repo.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_cubit.dart';
import 'package:gazzer/features/splash/cubit/splash_cubit.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';
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
import 'package:gazzer/features/wallet/data/wallet_repo_impl.dart';
import 'package:gazzer/features/wallet/domain/wallet_repo.dart';
import 'package:gazzer/features/wallet/presentation/cubit/add_balance_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/convert_points_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_transactions_cubit.dart';
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
  await dotenv.load(fileName: ".env");

  ///
  /// register buses
  _registerBuses();

  ///
  _registerCubits();
}

Future _registerAsync() async {
  di.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  di.registerSingletonAsync<PackageInfo>(() => PackageInfo.fromPlatform());

  ///
  await Future.wait([
    di.getAsync<SharedPreferences>(),
    di.getAsync<PackageInfo>(),
  ]);
}

void _registerRepos() {
  di.registerLazySingleton<AddressRepo>(
    () => AddressRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<RegisterRepo>(
    () => RegisterRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<LoginRepo>(() => LoginRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordImp(di.get(), di.get()),
  );
  di.registerLazySingleton<HomeRepo>(() => HomeRepoImp(di.get(), di.get()));
  di.registerLazySingleton<RestaurantsRepo>(
    () => RestaurantsRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<PlatesRepo>(() => PlatesRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<BannerRepo>(() => BannerRepoImp(di.get(), di.get()));
  di.registerLazySingleton<StoresRepo>(() => StoresRepoImp(di.get(), di.get()));
  di.registerLazySingleton<FavoritesRepo>(
    () => FavoritesRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<CartRepo>(() => CartRepoImp(di.get(), di.get()));
  di.registerLazySingleton<SearchRepo>(() => SearchRepoImp(di.get(), di.get()));
  di.registerLazySingleton<DailyOfferRepo>(
    () => DailyOfferRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<TopItemsRepo>(
    () => TopItemsRepoImpl(di.get(), di.get()),
  );
  di.registerLazySingleton<TopVendorsRepo>(
    () => TopVendorsRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<SuggestsRepo>(
    () => SuggestsRepoImpl(di.get(), di.get()),
  );
  di.registerLazySingleton<BestPopularRepository>(
    () => BestPopularRepositoryImpl(di.get(), di.get()),
  );
  di.registerLazySingleton<CheckoutRepo>(
    () => CheckoutRepoImp(di.get(), di.get()),
  );
  di.registerLazySingleton<LoyaltyProgramRepo>(
    () => LoyaltyProgramRepoImpl(di.get(), di.get()),
  );
  di.registerLazySingleton<WalletRepo>(
    () => WalletRepoImpl(di.get(), di.get()),
  );
}

void _registerBuses() {
  di.registerLazySingleton(() => FavoriteBus(di.get()));
  di.registerLazySingleton(() => AddressesBus(di.get()));
  di.registerLazySingleton<CartBus>(() => CartBus(di.get()));
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
  di.registerFactoryParam<StoresMenuCubit, int, Null>(
    (id, _) => StoresMenuCubit(di.get(), id),
  );
  di.registerFactoryParam<SingleCatRestaurantCubit, int, int>(
    (id, plateId) => SingleCatRestaurantCubit(di.get(), id, plateId),
  );
  di.registerFactoryParam<StoresOfCategoryCubit, int, int>(
    (mainId, subCatId) => StoresOfCategoryCubit(di.get(), mainId, subCatId),
  );
  di.registerFactoryParam<StoreDetailsCubit, int, Null>(
    (storeId, _) => StoreDetailsCubit(di.get(), storeId),
  );
  di.registerFactoryParam<PlateDetailsCubit, int, Null>(
    (plateId, _) => PlateDetailsCubit(di.get(), plateId),
  );
  di.registerFactoryParam<ProductDetailsCubit, int, Null>(
    (prodId, _) => ProductDetailsCubit(di.get(), prodId),
  );
  di.registerFactoryParam<AddEditAddressCubit, AddressEntity?, Null>(
    (address, _) => AddEditAddressCubit(di.get(), oldAddress: address),
  );
  di.registerFactoryParam<AddToCartCubit, (GenericItemEntity, List<ItemOptionEntity>), CartItemEntity?>(
    (item, cartItem) => AddToCartCubit(item.$1, item.$2, di.get(), di.get(), cartItem),
  );
  di.registerFactory(() => CartCubit(di.get(), di.get()));
  di.registerFactory(() => CheckoutCubit(di.get()));
  di.registerFactory(() => VouchersCubit(di.get()));
  di.registerFactory(() => CardsCubit(di.get()));
  di.registerFactory(() => SearchCubit(di.get()));
  di.registerFactory(() => DailyOfferCubit(di.get()));
  di.registerFactory(() => TopItemsCubit(di.get()));
  di.registerFactory(() => TopVendorsCubit(di.get()));
  di.registerFactory(() => SuggestsCubit(di.get()));
  di.registerFactory(() => BestPopularCubit(repository: di.get()));
  di.registerFactory(() => LoyaltyProgramCubit(di.get()));
  di.registerFactory(() => WalletCubit(di.get()));
  di.registerFactory(() => ConvertPointsCubit(di.get()));
  di.registerFactory(() => AddBalanceCubit(di.get()));
  di.registerFactory(() => WalletTransactionsCubit(di.get()));
}
