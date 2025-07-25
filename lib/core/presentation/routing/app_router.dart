import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/routing/router_observer.dart';
import 'package:gazzer/core/presentation/routing/routers/auth_routes.dart';
import 'package:gazzer/core/presentation/routing/routers/checkout_routes.dart';
import 'package:gazzer/core/presentation/routing/routers/nested_routes.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/presentation/views/add_edit_address_screen.dart';
import 'package:gazzer/features/auth/common/widgets/select_location_screen.dart';
import 'package:gazzer/features/intro/presentation/congrats_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/intro_video_tutorial_screen.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';
import 'package:gazzer/features/profile/presentation/views/delete_account_screen.dart';
import 'package:gazzer/features/splash/cubit/splash_cubit.dart';
import 'package:gazzer/features/splash/view/splash_screen.dart';
import 'package:gazzer/features/stores/pharmacy/presentation/pharmacy_menu/view/pharmacy_menu_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  navigatorKey: AppNavigator().mainKey,
  initialLocation: PharmacyMenuScreen.route,
  observers: [MyRouteObserver()],
  routes: [
    GoRoute(
      path: SplashScreen.route,
      builder: (context, state) => BlocProvider(create: (context) => di<SplashCubit>(), child: const SplashScreen()),
    ),

    ///
    nestedRoutes,
    ...authRoutes,
    ...checkoutRoutes,
    $addFoodToCartRoute,

    /// plan & intro
    $congratsScreenRoute,
    $loadingScreenRoute,
    $introVideoTutorialRoute,

    /// scattered;
    $deleteAccountRoute,
    $addEditAddressRoute,
    GoRoute(
      path: SelectLocationScreen.route,
      builder: (context, state) => const SelectLocationScreen(),
    ),

    ///
  ],
  // errorBuilder: (context, state) => const RouteNotFoundScreen(),
  redirect: (context, state) {
    // if (state.uri.toString().startsWith(AppConsts.deepLinkDomain)) {
    //   if (!allowedDeepLinkRoutes.any((e) => e.hasMatch(state.uri.path))) {
    //     return HomeScreen.routeName;
    //   }
    // }
    return null;
  },
);

// final allowedDeepLinkRoutes = [RegExp(r'/pr/[a-zA-Z0-9-_]+[\/]?$'), RegExp(r'/ca/?[a-zA-Z0-9-_]*[\/]?$')];
