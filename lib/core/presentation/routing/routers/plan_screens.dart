import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/health_focus_screen.dart';
import 'package:go_router/go_router.dart';

final planScreens = [
  GoRoute(
    path: HealthFocusScreen.route,
    builder: (context, state) => const HealthFocusScreen(),
  ),
  GoRoute(
    path: LoadingScreen.routeUriRoute,
    builder: (context, state) => LoadingScreen(navigateToRoute: state.uri.queryParameters['route']!),
  ),
];
