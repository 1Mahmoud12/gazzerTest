import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/features/drawer/views/main_drawer.dart';

class MenuNavigator extends StatelessWidget {
  const MenuNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AppNavigator().drawerKey,
      onDidRemovePage: (page) {},
      pages: [const MaterialPage(child: MainDrawer())],
    );
  }
}
