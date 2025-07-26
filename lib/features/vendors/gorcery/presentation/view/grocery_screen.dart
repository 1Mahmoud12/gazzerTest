import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/pkgs/infinite_scrolling.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/conrer_indented_clipper.dart';
import 'package:gazzer/core/presentation/utils/corner_indendet_shape.dart';
import 'package:gazzer/core/presentation/views/widgets/adds/image_with_aligned_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/rating_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';

part 'components/category_componenet_five.dart';
part 'components/category_componenet_four.dart';
part 'components/category_component_one.dart';
part 'components/category_component_three.dart';
part 'components/category_component_two.dart';
part 'components/infinite_carousal.dart';
part 'components/top_rated_component.dart';
part 'widgets/grocery_add_widget.dart';
part 'widgets/grocery_header.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});
  static const route = '/grocery';
  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _GroceryHeader(),
          const VerticalSpacing(24),
          // SubCategoriesWidget(addsIndeces: {}, onSubCategorySelected: (index) {}, subCategories: Fakers.fakeSubCats),
          const VerticalSpacing(24),
          const _GroceryAddWidget(),
          const VerticalSpacing(24),
          _TopRatedComponent(subcat: Fakers.fakeSubCats.first, vendors: Fakers.restaurants),
          const VerticalSpacing(24),
          CategoryComponentOne(subcat: Fakers.fakeSubCats.first, vendors: Fakers.restaurants),
          const VerticalSpacing(24),
          CategoryComponentTwo(subcat: Fakers.fakeSubCats.first, vendors: Fakers.restaurants),
          const VerticalSpacing(24),
          CategoryComponentThree(subcat: Fakers.fakeSubCats.first, vendors: Fakers.restaurants),
          const VerticalSpacing(24),
          Padding(
            padding: AppConst.defaultHrPadding,
            child: const ImageWithAlignedBtn(image: Assets.assetsPngGroceryAddBanner, align: Alignment(0.8, 0.95), btnText: "Shop Now"),
          ),
          const VerticalSpacing(24),
          _CategoryComponenetFour(subcat: Fakers.fakeSubCats.first, vendors: Fakers.restaurants),
          const VerticalSpacing(24),
          _CategoryComponenetFive(subcat: Fakers.fakeSubCats.first, vendors: Fakers.restaurants),
          const VerticalSpacing(24),
          const _InfinetAnimatingCarousal(),
          const VerticalSpacing(400),
        ],
      ),
    );
  }
}
