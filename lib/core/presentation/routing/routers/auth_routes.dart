import 'package:gazzer/features/auth/forgot_password/presentation/reset_password_screen.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/presentation/view/create_password_screen.dart';
import 'package:gazzer/features/auth/register/presentation/view/register_screen.dart';
import 'package:go_router/go_router.dart';

// TODO Make it part of app router file;

final authRoutes = [
  GoRoute(
    path: LoginScreen.route,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: RegisterScreen.route,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: CreatePasswordScreen.routeWithExtra,
    builder: (context, state) => CreatePasswordScreen(req: state.extra as RegisterRequest),
  ),
  GoRoute(
    path: ResetPasswordScreen.route,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
];
