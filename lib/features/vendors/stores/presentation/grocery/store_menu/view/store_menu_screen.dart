import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart' show CircleGradientBorderedImage;
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_switcher.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/groc_header_container.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/store_menu_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/stores_menu_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/stores_of_category_screen.dart';

class StoreMenuScreen extends StatelessWidget {
  const StoreMenuScreen({super.key, required this.state});
  static const route = '/store-menu';
  final StoresMenuStates state;
  @override
  Widget build(BuildContext context) {
    final banners = state.banners;
    final mainCat = state.mainCategory;
    final catWzPlates = state.categoryWithStores;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<StoresMenuCubit>().loadScreenData();
        },
        child: ScrollableTabedList(
          preHerader: Column(
            spacing: 16,
            children: [
              GrocHeaderContainer(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppBarRowWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          const HorizontalSpacing(6),
                          Expanded(child: MainSearchWidget(hintText: L10n.tr().searchForStoresItemsAndCAtegories)),
                          const HorizontalSpacing(AppConst.floatingCartWidth),
                        ],
                      ),
                      const SizedBox.shrink(),
                      GradientText(text: mainCat.name, style: TStyle.blackBold(22), textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
              if (banners.isNotEmpty) MainBannerWidget(banner: banners.first),
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
                child: Text(catWzPlates[index].$1.name, style: TStyle.blackSemi(13)),
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
