import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/store_menu_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/stores_menu_cubit.dart';
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
    final padding = MediaQuery.paddingOf(context);
    return LayoutBuilder(
      builder: (context, constraints) => FloatingDraggableWidget(
        floatingWidget: const SizedBox.shrink(),
        floatingWidgetHeight: 50,
        floatingWidgetWidth: 50,
        dy: padding.top + 60,
        dx: L10n.isAr(context) ? AppConst.defaultHrPadding.right : constraints.maxWidth - (50 + AppConst.defaultHrPadding.right),
        mainScreenWidget: Scaffold(
          body: BlocBuilder<StoresMenuCubit, StoresMenuStates>(
            builder: (context, state) {
              if (state is ScreenDataLoading || state is StoresMenuInit || state is ScreenDataError) {
                return Scaffold(
                  appBar:  MainAppBar(
                    // don't show cart : multiple hero
                  ),
                  body: state is ScreenDataError
                      ? FailureComponent(
                          message: L10n.tr().couldnotLoadDataPleaseTryAgain,
                          onRetry: () => context.read<StoresMenuCubit>().loadScreenData(),
                        )
                      : const Center(child: AdaptiveProgressIndicator()),
                );
              }
              return StoreMenuScreen(state: state);
            },
          ),
        ),
      ),
    );
  }
}
