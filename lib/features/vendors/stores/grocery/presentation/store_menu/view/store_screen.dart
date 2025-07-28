import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart'
    show CircleGradientBorderedImage;
import 'package:gazzer/features/vendors/resturants/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/resturants/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/stores/grocery/presentation/store_menu/view/components/store_horz_scroll_card_one_list.dart';
import 'package:gazzer/features/vendors/stores/grocery/presentation/store_menu/view/widgets/store_header_container.dart';
import 'package:gazzer/features/vendors/stores/grocery/presentation/stores_of_category/view/stores_of_category_screen.dart';

class StoreMenuScreen extends StatelessWidget {
  const StoreMenuScreen({super.key});
  static const route = '/store-menu';
  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      // dragLimit: DragLimit(bottom: MediaQuery.sizeOf(context).height - constraints.maxHeight),
      floatingWidget: const CartFloatingBtn(),
      floatingWidgetHeight: 50,
      floatingWidgetWidth: 50,
      mainScreenWidget: Scaffold(
        body: ScrollableTabedList(
          preHerader: Column(
            spacing: 16,
            children: [
              StoreHeaderContainer(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppBarRowWidget(),
                      MainSearchWidget(
                        hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                      ),
                      const SizedBox.shrink(),
                      GradientText(
                        text: "Grocery Stores",
                        style: TStyle.blackBold(22),
                      ),
                    ],
                  ),
                ),
              ),
              MainBannerWidget(
                banner: BannerEntity(id: 1, type: BannerType.image, image: Fakers.netWorkPRoductImage),
              ),
              const VerticalSpacing(8),
            ],
          ),
          itemsCount: Fakers.restaurants.length,
          tabContainerBuilder: (child) => ColoredBox(color: Co.bg, child: child),
          tabBuilder: (p0, index) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleGradientBorderedImage(image: Fakers.netWorkPRoductImage),
              Padding(
                padding: AppConst.defaultHrPadding,
                child: Text(Fakers.restaurants[index].name, style: TStyle.blackSemi(13)),
              ),
            ],
          ),
          listItemBuilder: (context, index) {
            final rest = Fakers.stores;
            final child = StoreHorzScrollCardOneList(
              items: rest,
              title: 'Category ${index + 1}',
              onViewAllPressed: () => StoresOfCategoryRoute(vendorId: rest[index].id).push(context),
              onSinglceCardPressed: (tiem) {
                print('Single card pressed: ${tiem.name}');
              },
            );

            return child;
          },
        ),
      ),
    );
  }
}
