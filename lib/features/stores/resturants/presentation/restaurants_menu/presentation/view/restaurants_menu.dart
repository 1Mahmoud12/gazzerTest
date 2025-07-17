import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show MainAppBar, VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/summer_sale_add_widget.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/components/horz_scroll_horz_card_vendors_list_component.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/components/horz_scroll_vert_card_vendors_list_component.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/components/vert_scroll_cert_card_vendor_grid_component.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/components/vert_scroll_horz_card_vendors_list_component.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/cat_rest_shaking_img_add_widget.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/cat_rest_slider_adds.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_carousal.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_last_chance_add_widget.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';

class RestaurantsMenu extends StatefulWidget {
  const RestaurantsMenu({super.key});
  static const route = '/restaurants-menu';
  @override
  State<RestaurantsMenu> createState() => _RestaurantsMenuState();
}

class _RestaurantsMenuState extends State<RestaurantsMenu> {
  late final RestaurantsMenuCubit cubit;
  final anchorController = AnchorScrollController();
  final nonVendorIndeces = [0, 1, 2, 3, 6, 9, 12, 15];
  final selectedIndex = ValueNotifier(0);

  final noCatWidgets = [
    const RestCatHeaderWidget(),
    const RestCatCarousal(),
    Padding(
      padding: AppConst.defaultHrPadding,
      child: Text(L10n.tr().chooseYourFavoriteVendor, style: TStyle.blackBold(16)),
    ),
    const SizedBox(), // replacing SubCategoriesWidget
    const CatRestShakingImgAddWidget(),
    const CatRestSliderAdds(),
    const SummerSaleAddWidget(),
    const RestCatLastChanceAddWidget(),
  ];

  @override
  void initState() {
    cubit = context.read<RestaurantsMenuCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.loadCategoriesOfPlates();
      cubit.loadPlates();
    });

    super.initState();
  }

  @override
  void dispose() {
    selectedIndex.dispose();
    anchorController.dispose();
    super.dispose();
  }

  Widget getCatComponent(CategoryOfPlateEntity cat, List<RestaurantEntity> rest) {
    switch (cat.style) {
      case CategoryStyle.horizontalScrollHorzCard:
        return HorzScrollHorzCardVendorsListComponent(catName: cat.name, catId: cat.id, rests: rest);
      case CategoryStyle.horizontalScrollVertCard:
        return HorzScrollVertCardVendorsListComponent(catName: cat.name, catId: cat.id, rests: rest);
      case CategoryStyle.verticalGrid:
        return VerticalVendorGridComponent(catName: cat.name, catId: cat.id, rests: rest);
      case CategoryStyle.horizontalScrollHorzCardCorner:
        return HorzScrollHorzCardVendorsListComponent(corner: Corner.bottomRight, catName: cat.name, catId: cat.id, rests: rest);
      case CategoryStyle.verticalScrollHorzCard:
        return VertScrollHorzCardVendorsListComponent(catName: cat.name, catId: cat.id, rests: rest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButton: const CartFloatingBtn(),
      body: BlocBuilder<RestaurantsMenuCubit, RestaurantsMenuStates>(
        builder: (context, state) {
          final cats = cubit.cats;
          return ListView.separated(
            controller: anchorController,
            padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
            itemCount: cats.length,
            separatorBuilder: (context, index) => const VerticalSpacing(12),
            itemBuilder: (context, index) {
              if (index == 3) {
                return AnchorItemWrapper(
                  index: index,
                  controller: anchorController,
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) => SubCategoriesWidget(
                      subCategories: cats
                          .map(
                            (e) => (name: e.$1.name, image: e.$1.image, id: e.$1.id, isAdd: e.$2),
                          )
                          .toList(),
                      onSubCategorySelected: (i) {
                        anchorController.scrollToIndex(index: i);
                        selectedIndex.value = i;
                      },
                      selectedId: value,
                    ),
                  ),
                );
              }
              return AnchorItemWrapper(
                index: index,
                controller: anchorController,
                child: Builder(
                  builder: (context) {
                    if (nonVendorIndeces.contains(index)) return noCatWidgets[nonVendorIndeces.indexOf(index)];
                    return getCatComponent(cats[index].$1, cubit.plates);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
