import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/view/components/store_horz_scroll_card_one_list.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/view/widgets/store_header_container.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/components/stores_top_rated_component.dart';
import 'package:go_router/go_router.dart';

part 'store_of_category_screen.g.dart';

@TypedGoRoute<StoresOfCategoryRoute>(path: StoresOfCategoryScreen.routeUriId)
@immutable
class StoresOfCategoryRoute extends GoRouteData with _$StoresOfCategoryRoute {
  const StoresOfCategoryRoute({required this.vendorId});
  final int vendorId;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StoresOfCategoryScreen(vendorId: vendorId);
  }
}

class StoresOfCategoryScreen extends StatelessWidget {
  static const routeUriId = '/stores-of-category';
  const StoresOfCategoryScreen({super.key, required this.vendorId});
  final int vendorId;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return FloatingDraggableWidget(
      floatingWidget: const CartFloatingBtn(),
      floatingWidgetHeight: 50,
      floatingWidgetWidth: 50,
      dx: mediaQuery.size.width - 80,
      dy: mediaQuery.padding.top + kToolbarHeight,
      mainScreenWidget: Scaffold(
        appBar: const MainAppBar(
          showCart: false,
          showLanguage: false,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            StoreHeaderContainer(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: MainSearchWidget(
                            height: 60,
                            hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                          ),
                        ),
                        HorizontalSpacing(AppConst.floatingCartWidth),
                      ],
                    ),
                    const SizedBox.shrink(),
                    GradientText(
                      text: "Fresh Fruits Markets",
                      style: TStyle.blackBold(22),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalSpacing(24),
            StoresTopRatedComponent(
              items: Fakers.plates,
            ),
            const VerticalSpacing(120),

            ...List.generate(
              4,
              (index) {
                return StoreHorzScrollCardOneList(
                  items: Fakers.stores,
                  title: 'Section ${index + 1}',
                  onViewAllPressed: () {},
                  onSinglceCardPressed: (tiem) {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
