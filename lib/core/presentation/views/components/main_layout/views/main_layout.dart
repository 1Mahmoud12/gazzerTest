import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_state.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/nav_bar/main_bnb.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:gazzer/features/drawer/views/main_drawer.dart';
import 'package:gazzer/features/favorites/presentation/views/favorites_screen.dart';
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

  final routes = {0: HomeScreen.route, 1: FavoritesScreen.route, 2: CartScreen.route, 3: OrdersScreen.route, 4: MainDrawer.route};

  String _getBaseRoute() {
    final baseRoute = widget.state.fullPath?.split('/')[1];
    return '/$baseRoute';
  }

  int _updateBNV(bool isInit) {
    final initRoute = _getBaseRoute();
    return routes.entries.firstWhere((k) => k.value == initRoute, orElse: () => routes.entries.first).key;
  }

  bool _shouldShowBottomNav() {
    final fullPath = widget.state.fullPath ?? '';
    // logger.d('full path: $fullPath');
    if (fullPath == '/' ||
        fullPath == '/favorites' ||
        fullPath == '/cart' ||
        fullPath == '/orders' ||
        fullPath == '/profile' ||
        fullPath == '/menu') {
      return true;
    }

    return false;
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
        currentRoute = _updateBNV(false);
        route.value = currentRoute;
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

            bottomNavigationBar: _shouldShowBottomNav()
                ? BlocBuilder<AppSettingsCubit, AppSettingsState>(
                    buildWhen: (previous, current) => previous.lang != current.lang,
                    builder: (context, state) => MainBnb(
                      initialIndex: value,
                      onItemSelected: (index) {
                        if (index == value) return;
                        route.value = index;
                        context.go(routes[index]!);
                      },
                    ),
                  )
                : null,
            floatingActionButton: _shouldShowBottomNav()
                ? _CartFloatingActionButton(
                    onPressed: () {
                      context.go(CartScreen.route);
                    },
                  )
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            drawerEnableOpenDragGesture: false,
            drawerDragStartBehavior: DragStartBehavior.down,
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

class _CartFloatingActionButton extends StatelessWidget {
  const _CartFloatingActionButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        SystemSound.play(SystemSoundType.click);
        onPressed();
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Progress ring
          BlocBuilder<CartCubit, CartStates>(
            buildWhen: (previous, current) {
              if (current is FullCartLoaded && previous is FullCartLoaded) {
                return previous.pouchSummary?.totalFillPercentage != current.pouchSummary?.totalFillPercentage;
              }
              return current is FullCartLoaded;
            },
            builder: (context, state) {
              double fillPercentage = 0.0;
              Color progressColor = Colors.green;

              if (state is FullCartLoaded && state.pouchSummary != null) {
                final pouchSummary = state.pouchSummary!;
                final totalCapacity = pouchSummary.totalCapacity?.toDouble() ?? 0.0;
                final totalLoad = pouchSummary.totalLoad?.toDouble() ?? 0.0;

                if (totalCapacity > 0) {
                  fillPercentage = (totalLoad / totalCapacity) * 100;
                  fillPercentage = fillPercentage.clamp(0.0, 100.0);
                }

                if (fillPercentage < 60) {
                  progressColor = Co.purple;
                } else if (fillPercentage < 85) {
                  progressColor = Co.purple;
                } else {
                  progressColor = Co.purple;
                }
              }
              return SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: fillPercentage / 100,
                  backgroundColor: Colors.grey.withOpacityNew(0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  strokeWidth: 5.0,
                ),
              );
            },
          ),
          // Cart icon
          SvgPicture.asset(Assets.cartIc, colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn)),
        ],
      ),
    );
  }
}
