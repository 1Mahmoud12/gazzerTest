import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/stores/resturants/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/stores/resturants/common/view/vert_card/horz_scroll_vert_card_vendors_list_component.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_carousal.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_of_category/presentation/view/restaurants_of_category_screen.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.loadCategoriesOfPlates();
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
            if (state is! RestaurantsCategoriesLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            final tabs = (state).categories.map((e) => (e.image, e.name, e.id)).toList();
            return Skeletonizer(
              enabled: false,
              child: ScrollableTabedList(
                preHerader: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RestCatHeaderWidget(
                      title: L10n.tr().bestMenuOfRestaurants,
                    ),
                    VerticalSpacing(topPadding + 16),
                    const RestCatCarousal(),
                    const VerticalSpacing(24),
                    Padding(
                      padding: AppConst.defaultHrPadding,
                      child: Text(L10n.tr().chooseYourFavoriteVendor, style: TStyle.blackBold(16)),
                    ),
                  ],
                ),
                itemsCount: tabs.length,
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
                  final rest = Fakers.vendors;
                  final child = HorzScrollVertCardVendorsListComponent(
                    items: rest,
                    title: tabs[index].$2,
                    onViewAllPressed: () => RestaurantsOfCategoryRoute(id: tabs[index].$3).push(context),
                  );

                  return child;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
