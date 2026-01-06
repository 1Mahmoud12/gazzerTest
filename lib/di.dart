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
import 'package:gazzer/features/home/homeViewAll/active_orders_widget/presentation/cubit/active_orders_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/best_popular_stores_widget/data/best_popular_stores_widget_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/best_popular_stores_widget/domain/best_popular_stores_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/best_popular_stores_widget/presentation/cubit/best_popular_stores_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/data/all_categories_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/data/categories_widget_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/domain/all_categories_repo.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/domain/categories_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/all_categories_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/categories_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/data/daily_offers_widget_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/domain/daily_offers_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/presentation/cubit/daily_offers_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/data/suggests_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/domain/suggests_repo.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/presentation/cubit/suggests_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/data/suggests_widget_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/domain/suggests_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/presentation/cubit/suggests_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/topItems/data/top_items_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/topItems/domain/top_items_repo.dart';
import 'package:gazzer/features/home/homeViewAll/topItems/presentation/cubit/top_items_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/top_items_widget/data/top_items_widget_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/top_items_widget/domain/top_items_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/top_items_widget/presentation/cubit/top_items_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors/data/top_vendors_repo_imp.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors/domain/top_vendors_repo.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors/presentation/cubit/top_vendors_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/data/top_vendors_widget_repo_impl.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/domain/top_vendors_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/presentation/cubit/top_vendors_widget_cubit.dart';
import 'package:gazzer/features/home/main_home/data/home_repo_imp.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/loyaltyProgram/data/loyalty_program_repo_impl.dart';
import 'package:gazzer/features/loyaltyProgram/domain/loyalty_program_repo.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/cubit/loyalty_program_cubit.dart';
import 'package:gazzer/features/orders/data/orders_repo_impl.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_review_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/reorder_cubit.dart';
import 'package:gazzer/features/profile/data/profile_repo_imp.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/search/data/search_repo_imp.dart';
import 'package:gazzer/features/search/domain/search_repo.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_cubit.dart';
import 'package:gazzer/features/share/data/share_repo_imp.dart';
import 'package:gazzer/features/share/domain/share_repo.dart';
import 'package:gazzer/features/splash/cubit/splash_cubit.dart';
import 'package:gazzer/features/supportScreen/data/chat_repo_imp.dart';
import 'package:gazzer/features/supportScreen/data/complaint_repo_imp.dart';
import 'package:gazzer/features/supportScreen/data/faq_rating_repo_imp.dart';
import 'package:gazzer/features/supportScreen/data/faq_repo_imp.dart';
import 'package:gazzer/features/supportScreen/data/working_hours_repo_imp.dart';
import 'package:gazzer/features/supportScreen/domain/chat_repo.dart';
import 'package:gazzer/features/supportScreen/domain/complaint_repo.dart';
import 'package:gazzer/features/supportScreen/domain/faq_rating_repo.dart';
import 'package:gazzer/features/supportScreen/domain/faq_repo.dart';
import 'package:gazzer/features/supportScreen/domain/working_hours_repo.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_rating_cubit.dart';
import 'package:gazzer/features/vendors/common/data/reviews_repo_impl.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';
import 'package:gazzer/features/vendors/common/domain/reviews_repo.dart';
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
import 'package:gazzer/features/wallet/presentation/cubit/voucher_vendors_cubit.dart';
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
  await dotenv.load();

  ///
  /// register buses
  _registerBuses();

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
  di.registerLazySingleton<CartRepo>(() => CartRepoImp(di.get(), di.get()));
  di.registerLazySingleton<SearchRepo>(() => SearchRepoImp(di.get(), di.get()));
  di.registerLazySingleton<DailyOfferRepo>(() => DailyOfferRepoImp(di.get(), di.get()));
  di.registerLazySingleton<TopItemsRepo>(() => TopItemsRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<TopVendorsRepo>(() => TopVendorsRepoImp(di.get(), di.get()));
  di.registerLazySingleton<SuggestsRepo>(() => SuggestsRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<BestPopularRepository>(() => BestPopularRepositoryImpl(di.get(), di.get()));
  di.registerLazySingleton<CategoriesWidgetRepo>(() => CategoriesWidgetRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<AllCategoriesRepo>(() => AllCategoriesRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<DailyOffersWidgetRepo>(() => DailyOffersWidgetRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<SuggestsWidgetRepo>(() => SuggestsWidgetRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<TopVendorsWidgetRepo>(() => TopVendorsWidgetRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<BestPopularStoresWidgetRepo>(() => BestPopularStoresWidgetRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<TopItemsWidgetRepo>(() => TopItemsWidgetRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<CheckoutRepo>(() => CheckoutRepoImp(di.get(), di.get()));
  di.registerLazySingleton<LoyaltyProgramRepo>(() => LoyaltyProgramRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<WalletRepo>(() => WalletRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<OrdersRepo>(() => OrdersRepoImpl(di.get(), di.get()));
  di.registerLazySingleton<FaqRepo>(() => FaqRepoImp(di.get(), di.get()));
  di.registerLazySingleton<FaqRatingRepo>(() => FaqRatingRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ChatRepo>(() => ChatRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ComplaintRepo>(() => ComplaintRepoImp(di.get(), di.get()));

  di.registerLazySingleton<WorkingHoursRepo>(() => WorkingHoursRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ShareRepo>(() => ShareRepoImp(di.get(), di.get()));
  di.registerLazySingleton<ReviewsRepo>(() => ReviewsRepoImpl(di.get(), di.get()));
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
  di.registerFactoryParam<RestaurantsOfCategoryCubit, int, void>((id, _) => RestaurantsOfCategoryCubit(di.get(), id));
  di.registerFactoryParam<SingleRestaurantCubit, int, void>((id, _) => SingleRestaurantCubit(di.get(), id));
  di.registerFactoryParam<StoresMenuCubit, int, void>((id, _) => StoresMenuCubit(di.get(), id));
  di.registerFactoryParam<SingleCatRestaurantCubit, int, int>((id, plateId) => SingleCatRestaurantCubit(di.get(), id, plateId));
  di.registerFactoryParam<StoresOfCategoryCubit, int, int>((mainId, subCatId) => StoresOfCategoryCubit(di.get(), mainId, subCatId));
  di.registerFactoryParam<StoreDetailsCubit, int, void>((storeId, _) => StoreDetailsCubit(di.get(), storeId));
  di.registerFactoryParam<PlateDetailsCubit, int, void>((plateId, _) => PlateDetailsCubit(di.get(), plateId));
  di.registerFactoryParam<ProductDetailsCubit, int, void>((prodId, _) => ProductDetailsCubit(di.get(), prodId));
  di.registerFactoryParam<AddEditAddressCubit, AddressEntity?, void>((address, _) => AddEditAddressCubit(di.get(), oldAddress: address));
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
  di.registerLazySingleton(() => CategoriesWidgetCubit(di.get()));
  di.registerLazySingleton(() => AllCategoriesCubit(di.get()));
  di.registerLazySingleton(() => DailyOffersWidgetCubit(di.get()));
  di.registerLazySingleton(() => SuggestsWidgetCubit(di.get()));
  di.registerLazySingleton(() => TopVendorsWidgetCubit(di.get()));
  di.registerLazySingleton(() => BestPopularStoresWidgetCubit(di.get()));
  di.registerLazySingleton(() => TopItemsWidgetCubit(di.get()));
  di.registerLazySingleton(() => ActiveOrdersWidgetCubit(di.get()));
  di.registerFactory(() => BestPopularCubit(repository: di.get()));
  di.registerFactory(() => LoyaltyProgramCubit(di.get()));
  di.registerFactory(() => WalletCubit(di.get()));
  di.registerFactory(() => ConvertPointsCubit(di.get()));
  di.registerFactory(() => VoucherVendorsCubit(di.get()));
  di.registerFactory(() => AddBalanceCubit(di.get()));
  di.registerFactory(() => WalletTransactionsCubit(di.get()));
  di.registerFactory(() => OrdersCubit(di.get()));
  di.registerFactory(() => ReorderCubit(di.get()));
  di.registerFactory(() => FaqCubit(di.get()));
  di.registerFactory(() => FaqRatingCubit(di.get()));
  di.registerFactory(() => OrderReviewCubit(di.get()));
}
