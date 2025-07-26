import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/alignment.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/image_in_nested_circles.dart';
import 'package:gazzer/core/presentation/views/widgets/products/rating_widget.dart';
import 'package:gazzer/features/vendors/resturants/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_horz_scroll_vert_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_vert_scroll_horz_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/widgets/infinet_carousal.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_restaurant_details.dart';
import 'package:go_router/go_router.dart';

// components
part 'components/explore_best.dart';
part 'components/pick_to_you.dart';
part 'components/today_picks_widget.dart';
part 'restaurants_of_category_screen.g.dart';
/// screen widgets
part 'widgets/add_widget.dart';
part 'widgets/type_related_restaurants_header.dart';

@TypedGoRoute<RestaurantsOfCategoryRoute>(path: RestaurantsOfCategoryScreen.routeUriId)
@immutable
class RestaurantsOfCategoryRoute extends GoRouteData with _$RestaurantsOfCategoryRoute {
  const RestaurantsOfCategoryRoute({required this.id});
  final int id;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RestaurantsOfCategoryScreen(id: id);
  }
}

class RestaurantsOfCategoryScreen extends StatelessWidget {
  const RestaurantsOfCategoryScreen({super.key, required this.id});
  final int id;
  static const routeUriId = '/cat-related-restaurant';
  @override
  Widget build(BuildContext context) {
    final items = [
      _TypeRelatedRestaurantsHeader(title: L10n.tr().burgerRestaurants),

      const LongitudinalCarousal([
        Assets.assetsPngSandwitchLayers,
        Assets.assetsPngSandwtichLayer2,
        Assets.assetsPngSandwitchLayers,
        Assets.assetsPngSandwtichLayer2,
        Assets.assetsPngSandwitchLayers,
        Assets.assetsPngSandwtichLayer2,
      ]),
      RestHorzScrollVertCardListComponent(
        title: L10n.tr().todayPicks,
        items: Fakers().restaurants,
        onViewAllPressed: null,
      ),
      RestVertScrollHorzCardListComponent(
        items: Fakers().restaurants,

        onViewAllPressed: null,
        title: L10n.tr().exploreBest,
      ),
      const _AddWidget(),
      const _PickToYou(),
    ];
    return Scaffold(
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => index < 1 ? const SizedBox.shrink() : const VerticalSpacing(24),
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
