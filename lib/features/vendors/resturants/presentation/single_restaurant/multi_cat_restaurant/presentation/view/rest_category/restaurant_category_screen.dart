import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/widgets/rest_cat_mini_product_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/widgets/grid_prod_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/widgets/header_widget.dart';
import 'package:go_router/go_router.dart';

part 'restaurant_category_screen.g.dart';

@TypedGoRoute<RestaurantCategoryRoute>(path: RestaurantCategoryScreen.route)
@immutable
class RestaurantCategoryRoute extends GoRouteData with _$RestaurantCategoryRoute {
  const RestaurantCategoryRoute({required this.subCatId, required this.subcatName, required this.$extra});
  final RestaurantEntity $extra;
  final int subCatId;
  final String subcatName;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RestaurantCategoryScreen(
      vendor: $extra,
      subCatId: subCatId,
      subcatName: subcatName,
    );
  }
}

class RestaurantCategoryScreen extends StatelessWidget {
  const RestaurantCategoryScreen({super.key, required this.vendor, required this.subCatId, required this.subcatName});
  final RestaurantEntity vendor;
  final int subCatId;
  final String subcatName;
  static const route = '/restaurant-category';
  @override
  Widget build(BuildContext context) {
    final nonCat = [
      MultiCatRestHeader(vendor: vendor),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Text(subcatName, style: TStyle.primaryBold(16)),
      ),
      AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20, mainAxisExtent: 85),
          padding: AppConst.defaultHrPadding,
          itemCount: Fakers().fakeProds.length,
          itemBuilder: (_, index) => RestCatMiniProductCard(prod: Fakers().fakeProds[index]),
        ),
      ),
      AspectRatio(
        aspectRatio: 390 / 140,
        child: Image.asset(Assets.assetsPngRestCatAdd, fit: BoxFit.cover),
      ),
      Padding(
        padding: AppConst.defaultHrPadding,
        child: Column(
          spacing: 12,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1, crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 8),

              itemBuilder: (_, index) {
                return SingleGridProduct(isTop: index.isEven, prod: Fakers().fakeProds[index]);
              },
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView.separated(
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 32),
        itemCount: nonCat.length,
        separatorBuilder: (context, index) => const VerticalSpacing(16),
        itemBuilder: (context, index) {
          return nonCat[index];
        },
      ),
    );
  }
}
