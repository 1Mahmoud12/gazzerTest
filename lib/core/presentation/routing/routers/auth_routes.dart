import 'package:flutter/material.dart';
import 'package:gazzer/features/auth/forgot_password/presentation/reset_password_screen.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/auth/register/presentation/view/create_password_screen.dart';
import 'package:gazzer/features/auth/register/presentation/view/register_screen.dart';
import 'package:gazzer/features/auth/verify/presentation/verify_otp_screen.dart';
import 'package:go_router/go_router.dart';

// TODO Make it part of app router file;

final authRoutes = [
  GoRoute(
    path: LoginScreen.route,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
  ),
  GoRoute(
    path: RegisterScreen.route,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: ResetPasswordScreen.route,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
  $createPasswordRoute,
  $verifyOTPScreenRoute,
];
