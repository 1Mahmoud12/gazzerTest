import 'package:flutter/material.dart';
import 'package:gazzer/features/splash/view/splash_screen.dart';

class AppNavigator {
  static final mainKey = GlobalKey<NavigatorState>();
  static String initialRoute = SplashScreen.route;

  // GlobalKey<NavigatorState> get mainKey => _mainKey;
}
