import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AppNavigator().homeKey,
      onDidRemovePage: (page) {},
      pages: [const MaterialPage(child: HomeScreen())],
    );
  }
}
