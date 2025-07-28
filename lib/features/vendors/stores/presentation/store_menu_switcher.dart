import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/stores/presentation/cubit/stores_menu_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/view/store_menu_screen.dart';
import 'package:go_router/go_router.dart';

part 'store_menu_switcher.g.dart';

@TypedGoRoute<StoreMenuSwitcherRoute>(path: StoreMenuSwitcher.route)
@immutable
class StoreMenuSwitcherRoute extends GoRouteData with _$StoreMenuSwitcherRoute {
  const StoreMenuSwitcherRoute({required this.id});
  final int id;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<StoresMenuCubit>(param1: id),
      child: const StoreMenuSwitcher(),
    );
  }
}

class StoreMenuSwitcher extends StatelessWidget {
  static const route = '/store-menu-switcher';
  const StoreMenuSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreMenuScreen();
  }
}
