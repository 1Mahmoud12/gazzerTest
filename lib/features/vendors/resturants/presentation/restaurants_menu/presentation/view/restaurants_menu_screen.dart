import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/lists/rest_horz_scroll_horz_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/lists/restaurants_list_switche.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/restaurants_of_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_banner_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';

// part 'widgets/rest_cat_carousal.dart';

class RestaurantsMenuScreen extends StatefulWidget {
  const RestaurantsMenuScreen({super.key});
  static const route = '/restaurants-menu';
  @override
  State<RestaurantsMenuScreen> createState() => _RestaurantsMenuScreenState();
}

class _RestaurantsMenuScreenState extends State<RestaurantsMenuScreen> {
  late final RestaurantsMenuCubit cubit;
  late final PageController _bannerPageController;

  @override
  void initState() {
    cubit = context.read<RestaurantsMenuCubit>();
    _bannerPageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.loadScreenData();
      // cubit.loadPlates();
    });

    super.initState();
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingDraggableWidget(
        floatingWidget: const SizedBox.shrink(),
        floatingWidgetHeight: 50,
        floatingWidgetWidth: 50,
        mainScreenWidget: BlocBuilder<RestaurantsMenuCubit, RestaurantsMenuStates>(
          buildWhen: (previous, current) => current is ScreenDataStates,
          builder: (context, state) {
            if (state is! ScreenDataStates) return const SizedBox.shrink();
            if (state is ScreenDataError) {
              return Column(
                children: [
                  const RestCatHeaderWidget(),
                  Expanded(
                    child: FailureComponent(message: L10n.tr().couldnotLoadDataPleaseTryAgain, onRetry: () => cubit.loadScreenData()),
                  ),
                ],
              );
            }
            final isLoading = state is ScreenDataLoading;
            final tabs = state.categories.map((e) => (e.$1.image, e.$1.name, e.$1.id)).toList();
            return RefreshIndicator(
              onRefresh: () async {
                cubit.loadScreenData();
              },
              child: Skeletonizer(
                enabled: isLoading,
                ignoreContainers: true,
                child: ScrollableTabedList(
                  ///
                  ///
                  preHerader: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RestCatHeaderWidget(),
                      Padding(
                        padding: AppConst.defaultHrPadding,
                        child: MainSearchWidget(height: 80, hintText: L10n.tr().searchForStoresItemsAndCAtegories),
                      ),
                      const VerticalSpacing(16),
                      //const RestCatCarousal(),
                      if (isLoading || state.banners.isNotEmpty)
                        BannerSlider(
                          images: isLoading ? Fakers.banners.map((e) => e.image ?? '').toList() : state.banners.map((e) => e.image ?? '').toList(),
                        ),
                      const VerticalSpacing(16),
                    ],
                  ),
                  itemsCount: (isLoading ? Fakers.categoriesOfPlate : state.categories).length,

                  ///
                  tabContainerBuilder: (child) => ColoredBox(color: Co.bg, child: child),
                  tabBuilder: (p0, index) {
                    final tab = isLoading ? ('test', 'Fakers._netWorkImage', index) : tabs[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Co.purple100),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomNetworkImage(tab.$1, width: 50, height: 50, fit: BoxFit.cover, borderRaduis: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            child: Text(tab.$2, style: TStyle.blackSemi(13)),
                          ),
                        ],
                      ),
                    );
                  },

                  ///
                  listItemBuilder: (context, index) {
                    final cat = isLoading ? (Fakers.categoryOfPlate, Fakers.restaurants) : state.categories[index];
                    return Column(
                      children: [
                        RestaurantsListSwitche(
                          title: cat.$1.name,
                          items: cat.$2.isNotEmpty ? cat.$2 : Fakers.restaurants,
                          onViewAllPressed: () => RestaurantsOfCategoryRoute(id: cat.$1.id).push(context),
                          cardImageToTextRatios: const {CardStyle.typeOne: 0.8},
                          corners: const {CardStyle.typeThree: Corner.topLeft},
                          onSingleCardPressed: (item) {
                            RestaurantDetailsRoute(id: item.id).push(context);
                          },
                          style: CardStyle.typeOne,
                        ),
                        if (index.isOdd && (index / 2).floor() < (state.banners.length - 1)) // skip first banner
                          MainBannerWidget(banner: state.banners[(index / 2).floor() + 1]),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final widgetMatrix = {(LayoutType.horizontal, CardStyle.typeOne): RestHorzScrollHorzCardListComponent};
}
