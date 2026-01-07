import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/groc_header_container.dart';

class SubcategoryItemsScreen extends StatelessWidget {
  static const route = '/subcategory-items';

  const SubcategoryItemsScreen({super.key, required this.items, required this.subcategoryName, required this.vendor, required this.maincat});

  final List<ProductEntity> items;
  final String subcategoryName;
  final GenericVendorEntity vendor;
  final CardStyle maincat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MainAppBar(
      //   onShare: () {},
      // ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        children: [
          GrocHeaderContainer(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              child: Column(
                children: [
                  const AppBarRowWidget(),
                  // Vendor Info Card
                  VendorInfoCard(
                    vendor,
                    categories: items.map((e) => e.name),
                    onTimerFinish: (ctx) {
                      // StoreDetailsRoute(
                      //   storeId: storeId,
                      // ).pushReplacement(ctx);
                    },
                  ),
                ],
              ),
            ),
          ),
          const VerticalSpacing(16),
          // Subcategory Items
          Expanded(child: _buildItemsContent(context)),
        ],
      ),
    );
  }

  Widget _buildItemsContent(BuildContext context) {
    // TODO: Replace with actual data from API/cubit
    // For now, showing empty state as requested
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: AppConst.defaultPadding,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.59,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return GrocProdCard(product: items[index], shape: maincat);
      },
    );
  }
}
