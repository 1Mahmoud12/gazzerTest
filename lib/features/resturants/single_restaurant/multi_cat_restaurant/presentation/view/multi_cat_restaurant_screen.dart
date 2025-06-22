import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/circular_carousal_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/overlaping_cards_slider.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/image_in_nested_circles.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/vendor_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';
import 'package:gazzer/features/resturants/single_restaurant/single_cat_restaurant/view/widgets/vendor_card.dart';

part 'component/top_rated_coponent.dart';
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

  final addsIndeces = {0, 1, 2};

  @override
  void dispose() {
    anchorController.dispose();
    super.dispose();
  }

  final vendor = Fakers.vendors.first;

  @override
  Widget build(BuildContext context) {
    final items = [
      _HeaderWidget(vendor: vendor),
      _TopRatedCoponent(anchorController: anchorController, addsIndeces: addsIndeces),
      const _SlidingAddsWidget(),
      SizedBox(
        height: 130,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          itemCount: Fakers.fakeProds.length,
          separatorBuilder: (context, index) => const HorizontalSpacing(24),
          itemBuilder: (context, index) {
            return _HorProductCard(prod: Fakers.fakeProds[index]);
          },
        ),
      ),
      SizedBox(
        height: 190,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          itemCount: Fakers.fakeProds.length,
          separatorBuilder: (context, index) => const HorizontalSpacing(24),
          itemBuilder: (context, index) {
            return _VertProductCard(prod: Fakers.fakeProds[index]);
          },
        ),
      ),
      SizedBox(
        height: 138,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          itemCount: Fakers.fakeProds.length,
          separatorBuilder: (context, index) => const HorizontalSpacing(16),
          itemBuilder: (context, index) {
            return _MiniProductCard(prod: Fakers.fakeProds[index]);
          },
        ),
      ),
      SizedBox(
        height: 138,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppConst.defaultHrPadding,
          itemCount: Fakers.fakeProds.length,
          separatorBuilder: (context, index) => const HorizontalSpacing(16),
          itemBuilder: (context, index) {
            return _MiniBorderedProductCard(prod: Fakers.fakeProds[index]);
          },
        ),
      ),
    ];
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView.separated(
        controller: anchorController,
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
        itemCount: items.length,
        separatorBuilder: (context, index) => index > 1 ? const VerticalSpacing(32) : const SizedBox.shrink(),
        itemBuilder: (context, index) {
          if (addsIndeces.contains(index)) {
            return items[index];
          }
          return AnchorItemWrapper(index: index, controller: anchorController, child: items[index]);
        },
      ),
    );
  }
}
