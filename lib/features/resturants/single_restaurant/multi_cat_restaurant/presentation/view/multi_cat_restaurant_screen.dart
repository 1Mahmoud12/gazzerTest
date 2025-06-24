import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/circular_carousal_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/overlaping_cards_slider.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/slide_timer.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/image_in_nested_circles.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/vendor_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';
import 'package:gazzer/features/resturants/single_restaurant/multi_cat_restaurant/presentation/view/widgets/grid_prod_card.dart';
import 'package:gazzer/features/resturants/single_restaurant/single_cat_restaurant/view/widgets/vendor_card.dart';

part './component/category_option_component.dart';
part 'component/daily_deals_add.dart';
part 'component/top_rated_coponent.dart';
part 'utils/multi_cat_rest_util.dart';
// part 'component/top_rated_component.dart';
part 'widgets/header_widget.dart';
part 'widgets/hor_product_card.dart';
part 'widgets/mini_bordered_product_card.dart';
part 'widgets/mini_product_card.dart';
part 'widgets/sliding_adds_widget.dart';
part 'widgets/top_rated_card.dart';
part 'widgets/vert_product_card.dart';

class MultiCatRestaurantsScreen extends StatefulWidget {
  const MultiCatRestaurantsScreen({super.key, required this.vendorId});
  final int vendorId;

  @override
  State<MultiCatRestaurantsScreen> createState() => _MultiCatRestaurantsScreenState();
}

class _MultiCatRestaurantsScreenState extends State<MultiCatRestaurantsScreen> {
  final anchorController = AnchorScrollController();
  final vendor = Fakers.vendors.first;

  final nonCatIndices = [0, 1, 2, 5];
  late final List<Widget> nonCat;
  final util = MultiCatRestUTils();

  final subCats = List.of(Fakers.fakeSubCats);
  @override
  void initState() {
    nonCat = [
      _HeaderWidget(vendor: vendor),
      _TopRatedCoponent(subCats: subCats, anchorController: anchorController, nonCatIndices: nonCatIndices.toSet()),
      const _SlidingAddsWidget(),
      const DailyDealsAdd(),
    ];
    for (final i in nonCatIndices) {
      subCats.insert(i, SubcategoryModel(id: -1, name: '', imageUrl: ''));
    }
    super.initState();
  }

  @override
  void dispose() {
    anchorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView.separated(
        controller: anchorController,
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 32),
        itemCount: subCats.length,
        separatorBuilder: (context, index) => index > 1 ? const VerticalSpacing(32) : const SizedBox.shrink(),
        itemBuilder: (context, index) {
          if (nonCatIndices.contains(index)) {
            return nonCat[nonCatIndices.indexOf(index)];
          }
          return AnchorItemWrapper(index: index, controller: anchorController, child: util.getCatWidget(subCats[index]));
        },
      ),
    );
  }
}
