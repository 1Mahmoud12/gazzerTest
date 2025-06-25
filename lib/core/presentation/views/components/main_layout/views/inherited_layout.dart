import 'package:flutter/material.dart';

class LayoutInherited extends InheritedWidget {
  /// this widget is used to provide control of main screen navigation to the widget tree
  const LayoutInherited({super.key, required this.changeIndex, required super.child});

  /// callback to change the index of the main screen
  final Function(int i) changeIndex;

  static LayoutInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LayoutInherited>();
  }

  static LayoutInherited of(BuildContext context) {
    final LayoutInherited? result = maybeOf(context);
    assert(result != null, 'No LayoutInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LayoutInherited oldWidget) => false;
}
