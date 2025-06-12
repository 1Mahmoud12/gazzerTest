import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show MainAppBar, VerticalSpacing;
import  'package:gazzer/core/presentation/views/widgets/summer_sale_add_widget.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/components/horz_scroll_horz_card_vendors_list_component.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/components/horz_scroll_vert_card_vendors_list_component.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/components/vert_scroll_cert_card_vendor_grid_component.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/components/vert_scroll_horz_card_vendors_list_component.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/cat_rest_shaking_img_add_widget.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/cat_rest_slider_adds.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/rest_cat_carousal.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/rest_cat_last_chance_add_widget.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/sub_categories_widget.dart';

class RestaurantsCatScreen extends StatefulWidget {
  const RestaurantsCatScreen({super.key, required this.id});
  final int id;

  @override
  State<RestaurantsCatScreen> createState() => _RestaurantsCatScreenState();
}

class _RestaurantsCatScreenState extends State<RestaurantsCatScreen> {
  final anchorController = AnchorScrollController();

  final nonVendorIndeces = {0, 1, 2, 3, 6, 10, 16, 19};

  final items = {
    0: const RestCatHeaderWidget(),
    1: const RestCatCarousal(),

    2: Padding(
      padding: AppConst.defaultHrPadding,
      child: Text("Choose your favorite vendor", style: TStyle.blackBold(16)),
    ),
    3: const SizedBox(), // replacing SubCategoriesWidget
    ///
    4: const HorzScrollHorzCardVendorsListComponent(),

    ///
    5: const HorzScrollVertCardVendorsListComponent(),

    // ///
    6: const CatRestShakingImgAddWidget(),

    // ///
    7: const HorzScrollHorzCardVendorsListComponent(),

    // ///
    8: const HorzScrollHorzCardVendorsListComponent(),

    // ///
    9: const VertScrollHorzCardVendorsListComponent(),

    // ///
    10: const CatRestSliderAdds(),

    // ///
    11: const HorzScrollHorzCardVendorsListComponent(corner: Corner.bottomLeft),

    // ///
    12: const HorzScrollHorzCardVendorsListComponent(),

    // ///
    13: const VerticalVendorGridComponent(),

    // ///
    14: const HorzScrollHorzCardVendorsListComponent(),

    // ///
    15: const HorzScrollHorzCardVendorsListComponent(),

    // ///
    16: const SummerSaleAddWidget(),

    // ///
    17: const HorzScrollHorzCardVendorsListComponent(),

    // ///
    18: const HorzScrollHorzCardVendorsListComponent(corner: Corner.bottomLeft),

    // ///
    19: const RestCatLastChanceAddWidget(),

    // ///
    // // const HorizontalVendorGridComponent(),

    // ///
    20: const HorzScrollVertCardVendorsListComponent(),
  };

  @override
  void dispose() {
    anchorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView.separated(
        controller: anchorController,
        padding: EdgeInsets.zero,
        itemCount: items.length,
        separatorBuilder: (context, index) => const VerticalSpacing(12),
        itemBuilder: (context, index) {
          if (index == 3) {
            return AnchorItemWrapper(
              index: index,
              controller: anchorController,
              child: SubCategoriesWidget(anchorController: anchorController, addsIndeces: nonVendorIndeces),
            );
          }
          return AnchorItemWrapper(index: index, controller: anchorController, child: items[index]!);
        },
      ),
    );
  }
}
