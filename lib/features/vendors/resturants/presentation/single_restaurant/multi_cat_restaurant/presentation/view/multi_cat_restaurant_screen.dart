import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/circular_carousal_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/restaurants_list_switche.dart';
import 'package:gazzer/features/vendors/resturants/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/restaurant__sub_category_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/widgets/header_widget.dart';

part 'component/top_rated_coponent.dart';
// part 'component/top_rated_component.dart';
part 'widgets/top_rated_card.dart';

class MultiCatRestaurantsScreen extends StatelessWidget {
  const MultiCatRestaurantsScreen({super.key, required this.toprated, required this.categoriesWithPlates, required this.banners, required this.restaurant});
  final RestaurantEntity restaurant;
  final List<PlateEntity> toprated;
  final List<(CategoryOfPlateEntity, List<GenericItemEntity>)> categoriesWithPlates;
  final List<BannerEntity> banners;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ScrollableTabedList(
        preHerader: Column(
          children: [
            MultiCatRestHeader(vendor: restaurant),
            _TopRatedComponent(toprated: toprated),
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
                child: Text(categoriesWithPlates[index].$1.name, style: TStyle.blackSemi(13)),
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
                items: cat.$2.isNotEmpty ? cat.$2 : Fakers.restaurants,
                onViewAllPressed: () {
                  RestaurantCategoryRoute(
                    $extra: restaurant,
                    subCatId: cat.$1.id,
                    subcatName: cat.$1.name,
                  ).push(context);
                },
                cardImageToTextRatios: {CardStyle.typeOne: 0.8},
                corners: {CardStyle.typeThree: Corner.topLeft},
                onSingleCardPressed: (item) {},
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
