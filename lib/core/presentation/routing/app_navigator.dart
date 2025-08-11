import 'package:flutter/material.dart';

class AppNavigator {
  static final AppNavigator _instance = AppNavigator._();
  AppNavigator._();
  factory AppNavigator() => _instance;

  final _mainKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get mainKey => _mainKey;
}
