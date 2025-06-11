import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/summer_sale_add_widget.dart';
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

class RestaurantsCatScreen extends StatelessWidget {
  const RestaurantsCatScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const RestCatHeaderWidget(),

          ///
          const RestCatCarousal(),
          const VerticalSpacing(24),

          ///
          const SubCategoriesWidget(),
          const VerticalSpacing(24),
          Padding(
            padding: AppConst.defaultHrPadding,
            child: Text("Choose your favorite vendor", style: TStyle.blackBold(16)),
          ),
          const HorzScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const HorzScrollVertCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const CatRestShakingImgAddWidget(),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const VertScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const CatRestSliderAdds(),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(corner: Corner.bottomLeft),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const VerticalVendorGridComponent(),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const SummerSaleAddWidget(),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(),
          const VerticalSpacing(25),

          ///
          const HorzScrollHorzCardVendorsListComponent(corner: Corner.bottomLeft),
          const VerticalSpacing(25),

          ///
          const RestCatLastChanceAddWidget(),
          const VerticalSpacing(25),

          ///
          // const HorizontalVendorGridComponent(),
          // const VerticalSpacing(80),

          ///
          const HorzScrollVertCardVendorsListComponent(),
          const VerticalSpacing(25),
        ],
      ),
    );
  }
}
