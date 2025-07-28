import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/routing/router_observer.dart';
import 'package:gazzer/core/presentation/routing/routers/nested_routes.dart';
import 'package:gazzer/core/presentation/routing/routers/unnested_routes.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/splash/cubit/splash_cubit.dart';
import 'package:gazzer/features/splash/view/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  navigatorKey: AppNavigator().mainKey,
  initialLocation: HomeScreen.route,
  observers: [MyRouteObserver()],
  routes: [
    GoRoute(
      path: SplashScreen.route,
      builder: (context, state) => BlocProvider(create: (context) => di<SplashCubit>(), child: const SplashScreen()),
    ),

    ///
    nestedRoutes,
    ...unnestedRoutes,

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
