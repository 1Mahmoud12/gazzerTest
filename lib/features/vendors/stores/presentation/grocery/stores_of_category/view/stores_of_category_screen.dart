import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_switcher.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/groc_header_container.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/cubit/stores_of_category_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/cubit/stores_of_category_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/components/stores_top_rated_component.dart';
import 'package:go_router/go_router.dart';

part 'stores_of_category_screen.g.dart';

@TypedGoRoute<StoresOfCategoryRoute>(path: StoresOfCategoryScreen.routeUriId)
@immutable
class StoresOfCategoryRoute extends GoRouteData with _$StoresOfCategoryRoute {
  const StoresOfCategoryRoute({required this.mainCatId, required this.subCatId});
  final int mainCatId;
  final int subCatId;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<StoresOfCategoryCubit>(param1: mainCatId, param2: subCatId),
      child: const StoresOfCategoryScreen(),
    );
  }
}

class StoresOfCategoryScreen extends StatelessWidget {
  static const routeUriId = '/stores-of-category';
  const StoresOfCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return FloatingDraggableWidget(
      floatingWidget: const MainCartWidget(),
      floatingWidgetHeight: 50,
      floatingWidgetWidth: 50,
      dx: mediaQuery.size.width - 80,
      dy: mediaQuery.padding.top + kToolbarHeight,
      mainScreenWidget: Scaffold(
        appBar: const MainAppBar(),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: BlocBuilder<StoresOfCategoryCubit, StoresOfCategoryStates>(
          builder: (context, state) {
            if (state is StoresOfCategoryLoading) {
              return const Center(child: AdaptiveProgressIndicator());
            } else if (state is StoresOfCategoryError) {
              return FailureComponent(
                message: L10n.tr().couldnotLoadDataPleaseTryAgain,
                onRetry: () => context.read<StoresOfCategoryCubit>().loadStoresOfCategory(),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                return context.read<StoresOfCategoryCubit>().loadStoresOfCategory();
              },
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  GrocHeaderContainer(
                    child: SafeArea(
                      child: Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            spacing: 12,
                            children: [
                              Expanded(child: MainSearchWidget(height: 60, hintText: L10n.tr().searchForStoresItemsAndCAtegories)),
                              HorizontalSpacing(AppConst.floatingCartWidth),
                            ],
                          ),
                          const SizedBox.shrink(),
                          GradientText(text: state.subCategory.name, style: TStyle.blackBold(22)),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpacing(24),
                  if (state.todaysDeals.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: StoresTopRatedComponent(items: state.todaysDeals),
                    ),

                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                    padding: AppConst.defaultPadding,
                    itemCount: state.stores.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.53,
                      // mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return GrocCardSwitcher<StoreEntity>(
                        width: 140,
                        entity: state.stores[index],
                        onPressed: () {
                          StoreDetailsRoute(storeId: state.stores[index].id).push(context);
                        },
                        // height: cardHeight,
                        cardStyle: CardStyle.typeOne,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
