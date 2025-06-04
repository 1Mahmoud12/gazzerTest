import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/utils/snackbars.dart';
import 'package:gazzer/features/drawer/views/main_drawer.dart';
import 'package:gazzer/features/favorites/views/favorites_screen.dart';
import 'package:gazzer/features/home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/menu/views/menu_screen.dart';
import 'package:gazzer/features/nav_bar/main_bnb.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, this.idnex});
  final int? idnex;
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late final ValueNotifier<int> indexNotifier;
  final canPop = ValueNotifier(false);
  int _prevIdenx = 0;

  _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen(key: ValueKey(0));
      case 1:
        return const FavoritesScreen(key: ValueKey(1));
      case 2:
        return const MenuScreen(key: ValueKey(2));
      case 3:
        return const MainDrawer(key: ValueKey(3));
      default:
        return const HomeScreen(key: ValueKey(4));
    }
  }

  @override
  void initState() {
    indexNotifier = ValueNotifier(widget.idnex ?? 0);
    _prevIdenx = widget.idnex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!canPop.value) {
          AppSnackbar.exitSnack(context);
          canPop.value = true;
          Future.delayed(const Duration(seconds: 2), () => canPop.value = false);
        } else {
          exit(0);
        }
      },
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: indexNotifier,
          builder: (context, value, child) => PageTransitionSwitcher(
            duration: Durations.long4,
            reverse: _prevIdenx > value,
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return SharedAxisTransition(
                fillColor: Colors.transparent,
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: _getScreen(value),
          ),
        ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: MainBnb(
            initialIndex: indexNotifier.value,
            onItemSelected: (index) {
              if (index == indexNotifier.value) return;
              _prevIdenx = indexNotifier.value;
              indexNotifier.value = index;
            },
          ),
        ),
      ),
    );
  }
}
