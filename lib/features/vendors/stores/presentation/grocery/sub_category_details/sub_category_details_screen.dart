import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/groc_header_container.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';

class SubCategoryDetailsScreen extends StatelessWidget {
  static const route = '/sub-category-details';

  const SubCategoryDetailsScreen({
    super.key,
    required this.subCategory,
    required this.products,
    required this.store,
    required this.cardStyle,
    required this.categories,
  });

  final StoreCategoryEntity subCategory;
  final List<ProductEntity> products;
  final StoreEntity store;
  final CardStyle cardStyle;
  final List<String>? categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onShare: () {},
        backgroundColor: Co.secondary,
      ),

      body: Column(
        spacing: 12,
        children: [
          GrocHeaderContainer(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top,
              ),
              child: VendorInfoCard(
                store,
                categories: categories,
                onTimerFinish: (ctx) {
                  StoreDetailsRoute(storeId: store.id).pushReplacement(ctx);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 12),
              children: [
                Padding(
                  padding: AppConst.defaultHrPadding,
                  child: TitleWithMore(title: subCategory.name),
                ),
                const SizedBox(height: 16),
                if (products.isEmpty)
                  FailureComponent(
                    message: L10n.tr().noData,
                  )
                else
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: AppConst.defaultPadding,
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.59,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GrocProdCard(
                        product: products[index],
                        shape: cardStyle,
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
