import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_horz_scroll_horz_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_horz_scroll_vert_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_vert_scroll_horz_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_vert_scroll_vert_card_grid_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/restaurants_of_category_screen.dart';

// part 'widgets/rest_cat_carousal.dart';

class RestaurantsMenuScreen extends StatefulWidget {
  const RestaurantsMenuScreen({super.key});
  static const route = '/restaurants-menu';
  @override
  State<RestaurantsMenuScreen> createState() => _RestaurantsMenuScreenState();
}

class _RestaurantsMenuScreenState extends State<RestaurantsMenuScreen> {
  late final RestaurantsMenuCubit cubit;

  @override
  void initState() {
    cubit = context.read<RestaurantsMenuCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.loadScreenData();
      // cubit.loadPlates();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      body: FloatingDraggableWidget(
        floatingWidget: const CartFloatingBtn(),
        floatingWidgetHeight: 50,
        floatingWidgetWidth: 50,
        mainScreenWidget: BlocBuilder<RestaurantsMenuCubit, RestaurantsMenuStates>(
          builder: (context, state) {
            if (state is! RestaurantsCategoriesStates) return const SizedBox.shrink();
            if (state is RestaurantsCategoriesLoading) {
              return const Center(child: AdaptiveProgressIndicator());
            }
            final tabs = state.categories.map((e) => (e.$1.image, e.$1.name, e.$1.id)).toList();
            return RefreshIndicator(
              onRefresh: () async {
                await cubit.loadScreenData();
              },
              child: ScrollableTabedList(
                preHerader: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RestCatHeaderWidget(
                      title: L10n.tr().bestMenuOfRestaurants,
                    ),
                    VerticalSpacing(topPadding + 16),
                    // const RestCatCarousal(),
                    if (state.banners.isNotEmpty) MainBannerWidget(banner: state.banners.first),
                    const VerticalSpacing(24),
                    Padding(
                      padding: AppConst.defaultHrPadding,
                      child: Text(L10n.tr().chooseYourFavoriteVendor, style: TStyle.blackBold(16)),
                    ),
                  ],
                ),
                itemsCount: state.categories.length,
                tabContainerBuilder: (child) => ColoredBox(color: Co.bg, child: child),
                tabBuilder: (p0, index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleGradientBorderedImage(image: tabs[index].$1),
                    Padding(
                      padding: AppConst.defaultHrPadding,
                      child: Text(tabs[index].$2, style: TStyle.blackSemi(13)),
                    ),
                  ],
                ),
                listItemBuilder: (context, index) {
                  final cat = state.categories[index];
                  return Column(
                    children: [
                      Builder(
                        builder: (context) {
                          switch (cat.$1.style) {
                            case CardStyle.typeOne:
                              return RestHorzScrollHorzCardListComponent(
                                title: cat.$1.name,
                                items: cat.$2,
                                imgToTextRatio: 0.8,
                                onViewAllPressed: () => RestaurantsOfCategoryRoute($extra: cat.$1).push(context),
                              );
                            case CardStyle.typeTwo:
                              return RestHorzScrollVertCardListComponent(
                                title: cat.$1.name,
                                onViewAllPressed: () => RestaurantsOfCategoryRoute($extra: cat.$1).push(context),
                                items: cat.$2,
                              );
                            case CardStyle.typeThree:
                              return RestVertScrollHorzCardListComponent(
                                items: cat.$2,
                                title: cat.$1.name,
                                onViewAllPressed: () => RestaurantsOfCategoryRoute($extra: cat.$1).push(context),
                                corner: Corner.topLeft,
                              );
                            case CardStyle.typeFour:
                              return RestVertScrollVertCardGridComponent(
                                items: cat.$2,
                                title: cat.$1.name,
                                onViewAllPressed: () => RestaurantsOfCategoryRoute($extra: cat.$1).push(context),
                              );
                          }
                        },
                      ),
                      if (index.isOdd && (index / 2).floor() < (state.banners.length - 1)) // skip first banner
                        MainBannerWidget(banner: state.banners[(index / 2).floor() + 1]),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  final widgetMatrix = {
    (LayoutType.horizontal, CardStyle.typeOne): RestHorzScrollHorzCardListComponent,
  };
}
