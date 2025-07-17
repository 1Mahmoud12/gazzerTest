import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';
import 'package:gazzer/features/profile/presentation/views/update_password_screen.dart';
import 'package:go_router/go_router.dart';

final drowerRoutes = [
  GoRoute(
    path: ProfileScreen.route,
    builder: (context, state) => const ProfileScreen(),
    routes: [
      GoRoute(path: UpodatePasswordScreen.routeWzValue, builder: (context, state) => const UpodatePasswordScreen()),
    ],
  ),
];
