import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
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
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_list_switche.dart';
import 'package:gazzer/features/vendors/resturants/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/restaurants_of_category_screen.dart';
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

  @override
  void initState() {
    cubit = context.read<RestaurantsMenuCubit>();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   cubit.loadScreenData();
    //   // cubit.loadPlates();
    // });

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
        mainScreenWidget: BlocConsumer<RestaurantsMenuCubit, RestaurantsMenuStates>(
          listener: (previous, current) {
            if (current is RestaurantsCategoriesLoaded) {
              for (final item in current.categories) {
                cubit.getVendors(item.$1.id);
              }
            }
          },
          buildWhen: (previous, current) => current is RestaurantsCategoriesStates,
          builder: (context, state) {
            if (state is! RestaurantsCategoriesStates) return const SizedBox.shrink();
            if (state is RestaurantsCategoriesLoading) {
              return const Center(child: AdaptiveProgressIndicator());
            }
            final tabs = state.categories.map((e) => (e.$1.image, e.$1.name, e.$1.id)).toList();
            return RefreshIndicator(
              onRefresh: () async {
                await Future.wait([cubit.getCategoriesOfPlates(), cubit.gettBanners()]);
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
                  return BlocBuilder<RestaurantsMenuCubit, RestaurantsMenuStates>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Skeletonizer(
                            ignoreContainers: true,
                            enabled: cat.$2.isEmpty,
                            child: AbsorbPointer(
                              absorbing: cat.$2.isEmpty,
                              child: Builder(
                                builder: (context) {
                                  return RestListSwitche(
                                    title: cat.$1.name,
                                    items: cat.$2.isNotEmpty ? cat.$2 : Fakers.restaurants,
                                    onViewAllPressed: () => RestaurantsOfCategoryRoute($extra: cat.$1).push(context),
                                    cardImageToTextRatios: {CardStyle.typeOne: 0.8},
                                    corners: {CardStyle.typeThree: Corner.topLeft},
                                    onSingleCardPressed: <RestaurantEntity>(item) {
                                      RestaurantsOfCategoryRoute($extra: cat.$1).push(context);
                                    },
                                    // TODO: Ask Product Owner about this
                                    style: index == state.categories.length - 1 ? CardStyle.typeThree : cat.$1.style,
                                  );
                                },
                              ),
                            ),
                          ),
                          if (index.isOdd && (index / 2).floor() < (state.banners.length - 1)) // skip first banner
                            MainBannerWidget(banner: state.banners[(index / 2).floor() + 1]),
                        ],
                      );
                    },
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
