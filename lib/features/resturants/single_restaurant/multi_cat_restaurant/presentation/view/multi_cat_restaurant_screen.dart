import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/routing/app_transitions.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/circular_carousal_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/overlaping_cards_slider.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/slide_timer.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/image_in_nested_circles.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/vendor_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';
import 'package:gazzer/features/resturants/single_restaurant/multi_cat_restaurant/presentation/view/rest_category/restaurant_category_screen.dart';
import 'package:gazzer/features/resturants/single_restaurant/multi_cat_restaurant/presentation/view/widgets/grid_prod_card.dart';
import 'package:gazzer/features/resturants/single_restaurant/multi_cat_restaurant/presentation/view/widgets/header_widget.dart';

part 'component/daily_deals_add.dart';
part 'component/top_rated_coponent.dart';
// part 'component/top_rated_component.dart';
part 'widgets/hor_product_card.dart';
part 'widgets/mini_bordered_product_card.dart';
part 'widgets/mini_product_card.dart';
part 'widgets/sliding_adds_widget.dart';
part 'widgets/top_rated_card.dart';
part 'widgets/vert_product_card.dart';

class MultiCatRestaurantsScreen extends StatelessWidget {
  const MultiCatRestaurantsScreen({super.key, required this.vendorId});
  final int vendorId;

  @override
  Widget build(BuildContext context) {
    final vendor = Fakers.vendors.first;
    final subCats = List.of(Fakers.fakeSubCats);
    final nonCat = [
      MultiCatRestHeader(vendor: vendor),
      _TopRatedCoponent(subCats: subCats, vendor: vendor),
      const _SlidingAddsWidget(),
      SizedBox(
        height: 130,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          separatorBuilder: (context, index) => const HorizontalSpacing(24),
          itemCount: Fakers.fakeProds.length,
          itemBuilder: (_, index) => _HorProductCard(prod: Fakers.fakeProds[index]),
        ),
      ),
      SizedBox(
        height: 190,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          separatorBuilder: (context, index) => const HorizontalSpacing(24),
          itemCount: Fakers.fakeProds.length,
          itemBuilder: (_, index) => _VertProductCard(prod: Fakers.fakeProds[index]),
        ),
      ),
      const DailyDealsAdd(),

      SizedBox(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          separatorBuilder: (context, index) => const HorizontalSpacing(16),
          itemCount: Fakers.fakeProds.length,
          itemBuilder: (_, index) => _MiniProductCard(prod: Fakers.fakeProds[index]),
        ),
      ),
      SizedBox(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          itemCount: Fakers.fakeProds.length,
          separatorBuilder: (context, index) => const HorizontalSpacing(16),
          itemBuilder: (_, index) => _MiniBorderedProductCard(prod: Fakers.fakeProds[index]),
        ),
      ),
      SizedBox(
        height: 125,
        width: double.infinity,
        child: Image.asset(Assets.assetsPngImpAnnounceAdd, fit: BoxFit.cover),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 8,
              ),

              itemBuilder: (_, index) {
                return SingleGridProduct(isTop: index.isEven, prod: Fakers.fakeProds[index]);
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
        separatorBuilder: (context, index) => index > 1 ? const VerticalSpacing(32) : const SizedBox.shrink(),
        itemBuilder: (context, index) {
          return nonCat[index];
        },
      ),
    );
  }
}
