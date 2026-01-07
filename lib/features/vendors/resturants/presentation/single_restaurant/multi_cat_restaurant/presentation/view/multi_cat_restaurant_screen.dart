import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/lists/restaurants_list_switche.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/restaurant_sub_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/widgets/header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_banner_slider.dart';
import 'package:go_router/go_router.dart';

part 'component/best_selling_component.dart';
part 'component/top_rated_coponent.dart';
part 'multi_cat_restaurant_screen.g.dart';
part 'widgets/best_selling_card.dart';
part 'widgets/top_rated_card.dart';

@TypedGoRoute<MultiCatRestaurantsRoute>(path: MultiCatRestaurantsScreen.route)
@immutable
class MultiCatRestaurantsRoute extends GoRouteData with _$MultiCatRestaurantsRoute {
  const MultiCatRestaurantsRoute({required this.$extra});
  final SingleRestaurantLoaded $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiCatRestaurantsScreen(state: $extra);
  }
}

class MultiCatRestaurantsScreen extends StatefulWidget {
  static const route = '/multi-cat-restaurant';

  const MultiCatRestaurantsScreen({super.key, required this.state});
  final SingleRestaurantLoaded state;
  @override
  State<MultiCatRestaurantsScreen> createState() => _MultiCatRestaurantsScreenState();
}

class _MultiCatRestaurantsScreenState extends State<MultiCatRestaurantsScreen> {
  late final RestaurantEntity restaurant;
  late final List<PlateEntity> toprated;
  late final List<PlateEntity> bestSelling;
  late final List<(CategoryOfPlateEntity, List<GenericItemEntity>)> categoriesWithPlates;
  late final List<BannerEntity> banners;

  @override
  void initState() {
    restaurant = widget.state.restaurant;
    toprated = widget.state.toprated;
    bestSelling = widget.state.bestSelling;
    categoriesWithPlates = widget.state.categoriesWithPlates;
    banners = widget.state.banners;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ScrollableTabedList(
        preHerader: Column(
          spacing: 8,
          children: [
            MultiCatRestHeader(restaurant: restaurant, categires: categoriesWithPlates.map((e) => e.$1.name)),
            BannerSlider(images: banners.map((e) => e.image ?? '').toList()),
            if (toprated.isNotEmpty) _TopRatedComponent(isCardDisabled: restaurant.isClosed, toprated: toprated.toList()),
            if (bestSelling.isNotEmpty) _BestSellingComponent(isCardDisabled: restaurant.isClosed, bestSelling: bestSelling),
          ],
        ),
        itemsCount: categoriesWithPlates.length,
        tabContainerBuilder: (child) => ColoredBox(color: Co.bg, child: child),
        tabBuilder: (p0, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleGradientBorderedImage(image: categoriesWithPlates[index].$1.image),
              Padding(
                padding: AppConst.defaultHrPadding,
                child: Text(categoriesWithPlates[index].$1.name, style: TStyle.robotBlackSmall()),
              ),
            ],
          );
        },

        ///
        listItemBuilder: (context, index) {
          final cat = categoriesWithPlates[index];
          return Column(
            children: [
              RestaurantsListSwitche(
                title: cat.$1.name,
                items: cat.$2.isNotEmpty ? cat.$2 : Fakers.plates,
                onViewAllPressed: cat.$2.length < 10
                    ? null
                    : () {
                        RestaurantCategoryRoute($extra: restaurant, subCatId: cat.$1.id, subcatName: cat.$1.name).push(context);
                      },
                cardImageToTextRatios: const {CardStyle.typeOne: 0.8},
                corners: const {CardStyle.typeThree: Corner.topLeft},
                onSingleCardPressed: (item) {
                  if (restaurant.isClosed) return;
                  PlateDetailsRoute(id: item.id).push(context);
                },
                // TODO: Ask Product Owner about this
                style: index == categoriesWithPlates.length - 1 ? CardStyle.typeThree : cat.$1.style,
              ),
              if (index.isOdd && (index / 2).floor() < (banners.length - 1)) // skip first banner
                MainBannerWidget(banner: banners[(index / 2).floor() + 1]),
            ],
          );
        },
      ),
    );
  }
}
