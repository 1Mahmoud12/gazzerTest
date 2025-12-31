import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:gazzer/features/dailyOffers/presentation/daily_offers_screen.dart';
import 'package:gazzer/features/drawer/views/main_drawer.dart';
import 'package:gazzer/features/favorites/presentation/views/favorites_screen.dart';
import 'package:gazzer/features/home/homeViewAll//suggested/presentation/view/suggested_screen.dart';
import 'package:gazzer/features/home/homeViewAll/topItems/presentation/view/popular_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';
import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_cubit.dart';
import 'package:gazzer/features/search/presentaion/view/search_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/restaurants_of_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/restaurant_sub_category_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/stores_menu_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/stores_of_category_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/pharmacy_menu/pharmacy_menu_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/store_menu_switcher.dart';
import 'package:go_router/go_router.dart';

ShellRoute get nestedRoutes => ShellRoute(
  builder: (context, state, child) {
    return MainLayout(state: state, child: child);
  },
  routes: [
    GoRoute(
      path: HomeScreen.route,
      builder: (context, state) => BlocProvider(create: (context) => di<HomeCubit>(), child: const HomeScreen()),
    ),

    /// *** home screen nested
    /// restauratns
    GoRoute(
      path: RestaurantsMenuScreen.route,
      builder: (context, state) => BlocProvider(create: (context) => di<RestaurantsMenuCubit>(), child: const RestaurantsMenuScreen()),
    ),
    $restaurantsOfCategoryRoute,
    $restaurantCategoryRoute,
    $multiCatRestaurantsRoute,

    /// stores
    $storeMenuSwitcherRoute,

    ///
    GoRoute(path: FavoritesScreen.route, builder: (context, state) => const FavoritesScreen()),

    ///
    GoRoute(path: CartScreen.route, builder: (context, state) => const CartScreen()),

    ///
    GoRoute(
      path: OrdersScreen.route,
      builder: (context, state) {
        // Handle both bool (legacy) and Map<String, dynamic> (new) extras
        if (state.extra is Map<String, dynamic>) {
          final extra = state.extra! as Map<String, dynamic>;
          return OrdersScreen(
            shouldRefreshAndOpenFirstOrder: extra['shouldRefreshAndOpenFirstOrder'] as bool? ?? false,
            showGetHelpInsteadOfReorder: extra['showGetHelpInsteadOfReorder'] as bool? ?? false,
          );
        } else if (state.extra is bool) {
          return OrdersScreen(shouldRefreshAndOpenFirstOrder: state.extra! as bool);
        } else {
          return const OrdersScreen();
        }
      },
    ),

    GoRoute(
      path: SearchScreen.route,
      builder: (context, state) => BlocProvider(create: (context) => di<SearchCubit>(), child: const SearchScreen()),
    ),

    // home categories
    GoRoute(
      path: SuggestedScreen.route,
      builder: (context, state) {
        return const SuggestedScreen();
      },
    ),
    GoRoute(
      path: DailyOffersScreen.route,
      builder: (context, state) {
        return const DailyOffersScreen();
      },
    ),
    GoRoute(
      path: PopularScreen.route,
      builder: (context, state) {
        return const PopularScreen();
      },
    ),

    /// stores related
    ...storesRoutes,

    /// pharmacy related
    ...pharmacyRoutes,

    ///
    ...drowerRoutes,
  ],
);

final storesRoutes = [$storeMenuSwitcherRoute, $storesOfCategoryRoute];

final pharmacyRoutes = [
  GoRoute(
    path: PharmacyMenuRoute.route,
    builder: (context, state) {
      final id = int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
      return BlocProvider(
        create: (context) => di<StoresMenuCubit>(param1: id),
        child: const PharmacyMenuScreen(),
      );
    },
  ),
];

List<RouteBase> get drowerRoutes => [
  GoRoute(
    path: MainDrawer.route,
    builder: (context, state) => const MainDrawer(),
    routes: [GoRoute(path: 'profile', builder: (context, state) => const ProfileScreen())],
  ),
];
