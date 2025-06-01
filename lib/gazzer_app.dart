import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/features/splash/view/splash_screen.dart';

class GazzerApp extends StatelessWidget {
  const GazzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      navigatorKey: AppConst.navKey,
      theme: AppTheme.lightTheme,

      builder: (context, child) {
        return child!;
      },
    );
  }
}
