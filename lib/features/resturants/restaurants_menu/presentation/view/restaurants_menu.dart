import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show MainAppBar, VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/summer_sale_add_widget.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/utils/sub_categories.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/cat_rest_shaking_img_add_widget.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/cat_rest_slider_adds.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/rest_cat_carousal.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/rest_cat_last_chance_add_widget.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';

class RestaurantsMenu extends StatefulWidget {
  const RestaurantsMenu({super.key, required this.id});
  final int id;

  @override
  State<RestaurantsMenu> createState() => _RestaurantsMenuState();
}

class _RestaurantsMenuState extends State<RestaurantsMenu> {
  final anchorController = AnchorScrollController();

  final nonVendorIndeces = [0, 1, 2, 3, 6, 9, 12, 15];
  final selectedIndex = ValueNotifier(0);

  final items = [
    const RestCatHeaderWidget(),
    const RestCatCarousal(),
    Padding(
      padding: AppConst.defaultHrPadding,
      child: Text("Choose your favorite vendor", style: TStyle.blackBold(16)),
    ),
    const SizedBox(), // replacing SubCategoriesWidget
    const CatRestShakingImgAddWidget(),
    const CatRestSliderAdds(),
    const SummerSaleAddWidget(),
    const RestCatLastChanceAddWidget(),
  ];

  final subCats = List.of(Fakers.fakeSubCats);

  @override
  void initState() {
    for (final i in nonVendorIndeces) {
      subCats.insert(i, SubcategoryModel(id: -1, name: '', imageUrl: ''));
    }
    super.initState();
  }

  @override
  void dispose() {
    selectedIndex.dispose();
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

        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
        itemCount: subCats.length,
        separatorBuilder: (context, index) => const VerticalSpacing(12),
        itemBuilder: (context, index) {
          if (index == 3) {
            return AnchorItemWrapper(
              index: index,
              controller: anchorController,
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, value, child) => SubCategoriesWidget(
                  subCategories: subCats,
                  onSubCategorySelected: (i) {
                    anchorController.scrollToIndex(index: i);
                    selectedIndex.value = i;
                  },
                  selectedId: value,
                  addsIndeces: nonVendorIndeces.toSet(),
                ),
              ),
            );
          }
          return AnchorItemWrapper(
            index: index,
            controller: anchorController,
            child: Builder(
              builder: (context) {
                if (nonVendorIndeces.contains(index)) return items[nonVendorIndeces.indexOf(index)];
                return SubCategories().getCatWidget(subCats[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
