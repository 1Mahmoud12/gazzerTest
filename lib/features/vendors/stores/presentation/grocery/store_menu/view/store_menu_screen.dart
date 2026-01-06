import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart' show CircleGradientBorderedImage;
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_switcher.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/store_menu_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/stores_menu_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/stores_of_category_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_banner_slider.dart';

class StoreMenuScreen extends StatelessWidget {
  const StoreMenuScreen({super.key, required this.state});
  static const route = '/store-menu';
  final StoresMenuStates state;
  @override
  Widget build(BuildContext context) {
    final banners = state.banners;
    final mainCat = state.mainCategory;
    final catWzPlates = state.categoryWithStores;
    final height = MediaQuery.paddingOf(context).top + (1.5 * kToolbarHeight);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<StoresMenuCubit>().loadScreenData();
        },
        child: ScrollableTabedList(
          preHerader: Column(
            spacing: 16,
            children: [
              SizedBox(
                height: height,
                child: Stack(
                  children: [
                    OverflowBox(
                      alignment: Alignment.centerRight,
                      maxHeight: height,
                      minHeight: height,
                      maxWidth: 780,
                      minWidth: 780,
                      child: Hero(
                        tag: Tags.spickyShape,
                        child: ClipPath(
                          clipper: AddShapeClipper(),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: Grad().bgLinear.copyWith(colors: [Co.storeGradient, Co.bg.withAlpha(0)], stops: const [0.0, 1]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    MainAppBar(title: L10n.tr().groceryStores),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MainSearchWidget(
                  hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                  bgColor: Colors.transparent,
                  prefix: const Icon(Icons.search, size: 24),
                ),
              ),
              if (banners.isNotEmpty) BannerSlider(images: banners.map((e) => e.image ?? '').toList()),
              const VerticalSpacing(8),
            ],
          ),
          itemsCount: catWzPlates.length,
          tabContainerBuilder: (child) => ColoredBox(color: Co.bg, child: child),
          tabBuilder: (p0, index) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleGradientBorderedImage(image: catWzPlates[index].$1.image),
              Padding(
                padding: AppConst.defaultHrPadding,
                child: Text(catWzPlates[index].$1.name, style: TStyle.robotBlackSmall()),
              ),
            ],
          ),
          listItemBuilder: (context, index) {
            final rest = catWzPlates[index].$2;
            final category = catWzPlates[index].$1;
            return Padding(
              padding: AppConst.defaultPadding,
              child: Column(
                spacing: 12,
                children: [
                  TitleWithMore(
                    title: category.name,
                    onPressed: () => StoresOfCategoryRoute(mainCatId: mainCat.id, subCatId: category.id).push(context),
                  ),
                  SizedBox(
                    height: 360,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: rest.length,
                      separatorBuilder: (context, index) => const HorizontalSpacing(12),
                      itemBuilder: (context, i) {
                        return GrocCardSwitcher<StoreEntity>(
                          cardStyle: category.style,
                          width: 160,
                          entity: rest[i],
                          onPressed: () {
                            StoreDetailsRoute(storeId: rest[i].id).push(context);
                          },
                        );
                      },
                    ),
                  ),

                  if (index.isOdd && (index / 2).floor() < (state.banners.length - 1)) // skip first banner
                    MainBannerWidget(banner: state.banners[(index / 2).floor()]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
