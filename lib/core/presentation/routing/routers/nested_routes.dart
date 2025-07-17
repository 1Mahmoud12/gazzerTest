import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/routing/routers/drawer_routes.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/views/favorites_screen.dart';
import 'package:gazzer/features/gorcery/presentation/view/grocery_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu.dart';
import 'package:go_router/go_router.dart';

final nestedRoutes = ShellRoute(
  builder: (context, state, child) {
    return const MainLayout(
      // path child as a widget
    );
  },
  routes: [
    GoRoute(
      path: HomeScreen.route,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: RestaurantsMenu.route,
          builder: (context, state) => BlocProvider(
            create: (context) => di<RestaurantsMenuCubit>(),
            child: const RestaurantsMenu(),
          ),
        ),
        GoRoute(path: GroceryScreen.route, builder: (context, state) => const GroceryScreen()),
      ],
    ),
    GoRoute(
      path: FavoritesScreen.route,
      routes: [
        ShellRoute(routes: []),
      ],
    ),
    GoRoute(
      path: OrdersScreen.route,
      routes: [
        ShellRoute(routes: []),
      ],
    ),
    ...drowerRoutes,
  ],
);
