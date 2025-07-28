import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/routing/routers/drawer_routes.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/views/favorites_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';
import 'package:gazzer/features/vendors/gorcery/presentation/view/grocery_screen.dart';
import 'package:gazzer/features/vendors/groceries/presentation/store_menu/view/store_screen.dart';
import 'package:gazzer/features/vendors/groceries/presentation/stores_of_category/view/stores_of_category_screen.dart';
import 'package:gazzer/features/vendors/pharmacy/presentation/pharmacy_menu/view/pharmacy_menu_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/restaurants_of_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/restaurant__sub_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:go_router/go_router.dart';

get nestedRoutes => ShellRoute(
  builder: (context, state, child) {
    return MainLayout(state: state, child: child);
  },
  routes: [
    GoRoute(
      path: HomeScreen.route,
      builder: (context, state) => BlocProvider(create: (context) => di<HomeCubit>(), child: const HomeScreen()),
    ),

    /// home screen nested
    GoRoute(
      path: RestaurantsMenuScreen.route,
      builder: (context, state) => BlocProvider(
        create: (context) => di<RestaurantsMenuCubit>(),
        child: const RestaurantsMenuScreen(),
      ),
    ),
    GoRoute(path: GroceryScreen.route, builder: (context, state) => const GroceryScreen()),
    $restaurantsOfCategoryRoute,
    $restaurantCategoryRoute,
    $restaurantDetilsRoute,

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
  GoRoute(
    path: StoreMenuScreen.route,
    builder: (context, state) => const StoreMenuScreen(),
  ),
  $storeOfCategoryRoute,
];

final pharmacyRoutes = [
  GoRoute(
    path: PharmacyMenuScreen.route,
    builder: (context, state) => const PharmacyMenuScreen(),
  ),
];
