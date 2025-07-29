import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/common/view/unscollable_tabed_list.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/view/components/groc_vert_scroll_grid.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/view/widgets/groc_header_container.dart';
import 'package:go_router/go_router.dart';

part 'store_details_screen.g.dart';

@TypedGoRoute<StoreDetailsRoute>(path: StoreDetailsScreen.route)
@immutable
class StoreDetailsRoute extends GoRouteData with _$StoreDetailsRoute {
  const StoreDetailsRoute({required this.storeId});
  final int storeId;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StoreDetailsScreen(storeId: storeId);
  }
}

class StoreDetailsScreen extends StatelessWidget {
  static const route = '/store-details';
  const StoreDetailsScreen({super.key, required this.storeId});
  final int storeId;
  @override
  Widget build(BuildContext context) {
    final cats = Fakers.storeCats;
    final prods = Fakers.fakeProds;
    return Scaffold(
      appBar: MainAppBar(
        showCart: true,
        onShare: () {},
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        children: [
          GrocHeaderContainer(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + kToolbarHeight + 8,
                bottom: 16,
              ),
              child: VendorInfoCard(Fakers.stores.first),
            ),
          ),
          Expanded(
            child: UnScollableLTabedList(
              tabs: cats.map((e) => (e.image, e.name)).toList(),
              maxHeight: 300,
              itemCount: cats.length,
              listItemBuilder: (context, index) {
                return GrocVertScrollGrid(
                  title: cats[index].name,
                  onViewAllPressed: null,
                  items: prods,
                  onSinglceCardPressed: (item) {},
                  shrinkWrap: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
