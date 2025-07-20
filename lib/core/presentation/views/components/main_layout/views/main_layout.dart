import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/nav_bar/main_bnb.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/drawer/views/main_drawer.dart';
import 'package:gazzer/features/favorites/views/favorites_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hotspot/hotspot.dart' show HotspotProvider;

class MainLayout extends StatefulWidget {
  static const route = '/main';

  /// Main layout that provide smooth transitions etween the main screens, it contains the bottom navigation bar and the main screens.
  /// [idnex] is the initial index of the bottom navigation bar, if not provided, it defaults to 0
  const MainLayout({super.key, required this.child, required this.state});
  final Widget child;
  final GoRouterState state;
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final canPop = ValueNotifier(false);

  late final ValueNotifier<int> route;
  late int currentRoute;

  final routes = {0: HomeScreen.route, 1: FavoritesScreen.route, 2: OrdersScreen.route};

  String _getBaseRoute() {
    final baseRoute = widget.state.fullPath?.split('/')[1];
    print("FULL PATH IS  :::::::::::::: ${widget.state.fullPath}");
    print("BASE ROUTE IS :::::::::::::: $baseRoute");
    return "/$baseRoute";
  }

  int _updateBNV(bool isInit) {
    final initRoute = _getBaseRoute();
    return routes.entries.firstWhere((k) => k.value == initRoute, orElse: () => routes.entries.first).key;
  }

  @override
  void initState() {
    currentRoute = _updateBNV(true);
    route = ValueNotifier(currentRoute);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainLayout oldWidget) {
    if (oldWidget.state.fullPath != widget.state.fullPath) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateBNV(false);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GuideProvider(
      shouldProvide: () => Session().showTour,
      child: PopScope(
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
        child: ValueListenableBuilder(
          valueListenable: route,
          builder: (context, value, child) => Scaffold(
            body: widget.child,
            bottomNavigationBar: Builder(
              builder: (context) {
                return MainBnb(
                  initialIndex: value,
                  onItemSelected: (index) {
                    if (index == 3) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Scaffold.of(context).openEndDrawer();
                      });
                      return;
                    }
                    if (index == value) return;

                    route.value = index;
                    context.pushReplacement(routes[index]!);
                  },
                );
              },
            ),
            endDrawer: const MainDrawer(),
          ),
        ),
      ),
    );
  }
}

class GuideProvider extends StatelessWidget {
  /// This widgets provide [HotspotProvider] widget as parent to the
  /// given child if the condition is fulfilled
  const GuideProvider({super.key, required this.child, required this.shouldProvide});
  final Widget child;
  final bool Function() shouldProvide;
  @override
  Widget build(BuildContext context) {
    if (shouldProvide()) {
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
