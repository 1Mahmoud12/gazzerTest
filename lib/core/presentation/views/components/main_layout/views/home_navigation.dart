import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  late final HeroController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController(
      createRectTween: (begin, end) => MaterialRectArcTween(begin: begin, end: end),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AppNavigator().homeKey,
      observers: [_heroController],
      onDidRemovePage: (page) {},
      pages: [const MaterialPage(child: HomeScreen())],
    );
  }
}
