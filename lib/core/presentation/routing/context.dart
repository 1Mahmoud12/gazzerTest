import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

extension NavigationHelper on BuildContext {
  Future<T?> myPush<T>(Widget widget) async {
    final result = await Navigator.of(this).push<T>(MaterialPageRoute(builder: (context) => widget));
    return result;
  }

  Future<T?> myPushNamed<T>(String name) async {
    final result = await Navigator.of(this).pushNamed<T>(name);
    return result;
  }

  Future<T?> myShowDialog<T>(Widget widget, {bool dissmisable = true}) async {
    final result = showDialog<T>(barrierDismissible: dissmisable, context: this, builder: (context) => widget);
    return result;
  }

  Future<T?> showMBottomSheet<T>({required Widget child, bool isDismissible = false}) {
    return showModalBottomSheet<T>(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(this).height * 0.85, minHeight: MediaQuery.sizeOf(this).height * 0.35),
      shape: const StadiumBorder(),
      backgroundColor: Co.white,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      enableDrag: true,
      isDismissible: isDismissible,
      context: this,
      builder: (context) => child,
    );
  }

  Future<T?> myPushReplacment<T>(Widget widget) async {
    final result = await Navigator.of(this).pushReplacement<T, dynamic>(MaterialPageRoute(builder: (context) => widget));
    return result;
  }

  Future<T?> myPushAndRemoveUntil<T>(Widget widget) async {
    final result = await Navigator.of(this).pushAndRemoveUntil<T>(MaterialPageRoute(builder: (context) => widget), (route) => false);
    return result;
  }

  Future<T?> myPushAndRemoveUntilNamed<T>(Widget widget, String routeName) async {
    final result = Navigator.of(this).pushAndRemoveUntil<T>(MaterialPageRoute(builder: (context) => widget), ModalRoute.withName(routeName));
    return result;
  }

  Future<T?> myPopAndPushNamed<T>(String name) async {
    final result = await Navigator.of(this).popAndPushNamed<T, dynamic>(name);
    return result;
  }

  myPopUntil(String name) {
    Navigator.of(this).popUntil(ModalRoute.withName(name));
  }

  Future<void> myPop({dynamic result}) async {
    Navigator.of(this).pop(result);
  }

  myPopUntilFirstScreen() {
    if (Navigator.canPop(this)) {
      Navigator.of(this).popUntil((route) => route.isFirst);
    }
  }

  myPopAll() {
    Navigator.of(this).popUntil((route) => false);
  }
}
