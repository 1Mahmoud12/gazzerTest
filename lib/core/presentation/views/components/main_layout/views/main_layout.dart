import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/fav_navigator.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/home_navigation.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/inherited_layout.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/orders_navigator.dart';
import 'package:gazzer/core/presentation/views/components/nav_bar/main_bnb.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/drawer/views/main_drawer.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:hotspot/hotspot.dart' show HotspotProvider;

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

  changeIndex(int index) {
    if (index == indexNotifier.value) return false;
    _prevIdenx = indexNotifier.value;
    indexNotifier.value = index;
  }

  _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeNavigation(key: ValueKey(0));
      case 1:
        return const FavNavigator(key: ValueKey(1));
      case 2:
        return const OrdersNavigator(key: ValueKey(2));
      case 3:
        break;
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
    final child = PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!canPop.value) {
          Alerts.exitSnack(context);
          canPop.value = true;
          Future.delayed(const Duration(seconds: 2), () => canPop.value = false);
        } else {
          exit(0);
        }
      },
      child: LayoutInherited(
        changeIndex: changeIndex,
        child: ValueListenableBuilder(
          valueListenable: indexNotifier,
          builder: (context, value, child) => Scaffold(
            body: PageTransitionSwitcher(
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

            bottomNavigationBar: Builder(
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: MainBnb(
                    initialIndex: indexNotifier.value,
                    onItemSelected: (index) {
                      if (index == 3) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Scaffold.of(context).openEndDrawer();
                        });
                        return;
                      }
                      if (index == indexNotifier.value) return;
                      _prevIdenx = indexNotifier.value;
                      indexNotifier.value = index;
                    },
                  ),
                );
              },
            ),
            endDrawer: const MainDrawer(),
          ),
        ),
      ),
    );
    if (Session().showTour) {
      return HotspotProvider(
        skrimColor: Colors.black54,
        dismissibleSkrim: true,
        bodyWidth: 220,
        foregroundColor: Colors.green,
        duration: Durations.extralong4,
        backgroundColor: Co.purple,
        padding: const EdgeInsets.all(8),
        curve: Curves.fastOutSlowIn,
        hotspotShapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        tailSize: const Size(35, 42),
        actionBuilder: (context, controller) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                controller.next();
              },
              style: TextButton.styleFrom(
                backgroundColor: Co.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(L10n.tr().gotIt, style: TStyle.whiteBold(16)),
            ),
          ],
        ),
        child: child,
      );
    }
    return child;
  }
}
