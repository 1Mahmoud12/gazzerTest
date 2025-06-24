import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/routing/context.dart';

/// The app has 5 navigator key, on is the main that assigned to matrial app,
/// others are assigned to widgets corresponding to each tab in the bottom navigation bar (BNB).
/// The widgets thar are corresponding to BNB tabs have a [Navigator] widget at its root, that is used to
///  manage a nested navigation stack of that tab.
///
/// The normal navigator method in the whole app is Navigator.of(context).push(...).
/// This method looks up in the widget tree to find the nearest Navigator widget and push a new page
/// onto its stack.
///
/// This class is our way to push a page in a specific navigator key (not the nearest one).

enum Parent { main, home, fav, orders, menu }

class AppNavigator {
  static final AppNavigator _instance = AppNavigator._();
  AppNavigator._();
  factory AppNavigator() => _instance;

  final _mainKey = GlobalKey<NavigatorState>();
  final _homeKey = GlobalKey<NavigatorState>();
  final _favKey = GlobalKey<NavigatorState>();
  final _ordersKey = GlobalKey<NavigatorState>();
  final _drawerKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get mainKey => _mainKey;
  GlobalKey<NavigatorState> get homeKey => _homeKey;
  GlobalKey<NavigatorState> get favKey => _favKey;
  GlobalKey<NavigatorState> get ordersKey => _ordersKey;
  GlobalKey<NavigatorState> get drawerKey => _drawerKey;

  late BuildContext _lastUsed;
  BuildContext get context => _lastUsed;
  set initContext(BuildContext value) {
    _lastUsed = value;
  }

  BuildContext _getContext(Parent par) {
    BuildContext? context = switch (par) {
      Parent.main => _mainKey.currentContext,
      Parent.home => _homeKey.currentContext,
      Parent.fav => _favKey.currentContext,
      Parent.orders => _ordersKey.currentContext,
      Parent.menu => _drawerKey.currentContext,
    };

    if (context == null) throw Exception('Navigator context for $par is null');
    _lastUsed = context;
    return context;
  }

  Future<T?> push<T>(Widget widget, {Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    final result = await context.myPush<T>(widget);
    return result;
  }

  Future<T?> pushNamed<T>(String name, {Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    final result = await context.myPushNamed<T>(name);
    return result;
  }

  Future<T?> showDialog<T>(Widget widget, {bool dissmisable = true, Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    final result = await context.myShowDialog<T>(widget, dissmisable: dissmisable);
    return result;
  }

  Future<T?> showBottomSheet<T>({required Widget child, bool isDismissible = false, Parent parent = Parent.main}) {
    final context = _getContext(parent);
    return context.showMBottomSheet<T>(child: child, isDismissible: isDismissible);
  }

  Future<T?> pushReplacement<T>(Widget widget, {Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    final result = await context.myPushReplacment<T>(widget);
    return result;
  }

  Future<T?> pushAndRemoveUntil<T>(Widget widget, {Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    final result = await context.myPushAndRemoveUntil<T>(widget);
    return result;
  }

  Future<T?> pushAndRemoveUntilNamed<T>(Widget widget, String routeName, {Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    final result = await context.myPushAndRemoveUntilNamed<T>(widget, routeName);
    return result;
  }

  Future<T?> popAndPushNamed<T>(String name, {Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    final result = await context.myPopAndPushNamed<T>(name);
    return result;
  }

  void popUntil(String name, {Parent parent = Parent.main}) {
    final context = _getContext(parent);
    context.myPopUntil(name);
  }

  Future<void> pop({dynamic result, Parent parent = Parent.main}) async {
    final context = _getContext(parent);
    await context.myPop(result: result);
  }

  void popUntilFirstScreen({Parent parent = Parent.main}) {
    final context = _getContext(parent);
    context.myPopUntilFirstScreen();
  }

  void popAll({Parent parent = Parent.main}) {
    final context = _getContext(parent);
    context.myPopAll();
  }
}
