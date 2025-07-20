import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/routing/routers/drawer_routes.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/views/favorites_screen.dart';
import 'package:gazzer/features/gorcery/presentation/view/grocery_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu.dart';
import 'package:gazzer/features/stores/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/restaurant_category_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_restaurant_details.dart';
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
      path: RestaurantsMenu.route,
      builder: (context, state) => BlocProvider(
        create: (context) => di<RestaurantsMenuCubit>(),
        child: const RestaurantsMenu(),
      ),
    ),
    GoRoute(path: GroceryScreen.route, builder: (context, state) => const GroceryScreen()),
    $catRelatedRestaurantsRoute,
    $multiCatRestaurantsRoute,
    $restaurantCategoryRoute,
    $singleCatRestaurantRoute,

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

    ///
    ...drowerRoutes,
  ],
);
