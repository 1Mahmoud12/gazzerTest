import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/presentation/views/favorites_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';
import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';
import 'package:gazzer/features/profile/presentation/views/update_password_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/restaurants_of_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/restaurant_sub_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/stores_of_category_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/pharmacy_menu/view/pharmacy_menu_screen.dart';
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
      builder: (context, state) => BlocProvider(
        create: (context) => di<RestaurantsMenuCubit>(),
        child: const RestaurantsMenuScreen(),
      ),
    ),
    $restaurantsOfCategoryRoute,
    $restaurantCategoryRoute,
    $restaurantDetilsRoute,
    $multiCatRestaurantsRoute,

    /// stores
    $storeMenuSwitcherRoute,

    ///
    GoRoute(
      path: FavoritesScreen.route,
      builder: (context, state) => const FavoritesScreen(),
      routes: [
        // ShellRoute(routes: []),
      ],
    ),

    ///
    GoRoute(
      path: OrdersScreen.route,
      builder: (context, state) => const OrdersScreen(),
      routes: [
        // ShellRoute(routes: []),
      ],
    ),

    /// stores related
    ...storesRoutes,

    /// pharmacy related
    ...pharmacyRoutes,

    ///
    ...drowerRoutes,
  ],
);

final storesRoutes = [
  $storeMenuSwitcherRoute,

  $storesOfCategoryRoute,
  $storeDetailsRoute,
];

final pharmacyRoutes = [
  GoRoute(
    path: PharmacyMenuScreen.route,
    builder: (context, state) => const PharmacyMenuScreen(),
  ),
];

List<RouteBase> get drowerRoutes => [
  GoRoute(
    path: ProfileScreen.route,
    builder: (context, state) => const ProfileScreen(),
    routes: [],
  ),
  $upodatePasswordRoute,
];
