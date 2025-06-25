import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/features/splash/view/splash_screen.dart';

class GazzerApp extends StatelessWidget {
  const GazzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      navigatorKey: AppNavigator().mainKey,
      theme: AppTheme.lightTheme,
      localizationsDelegates: L10n.localizationDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: L10n.supportedLocales.first,
    );
  }
}
