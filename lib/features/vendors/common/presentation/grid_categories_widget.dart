import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
    required this.maincat,
    required this.onSinglceCardPressed,
    required this.subcats,
    required this.products,
    required this.vendor,
  });

  final StoreCategoryEntity maincat;
  final Function(dynamic item) onSinglceCardPressed;
  final List<StoreCategoryEntity> subcats;
  final List<ProductEntity> products;
  final GenericVendorEntity vendor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: TitleWithMore(title: maincat.name),
        ),
        Wrap(
          children: List.generate(products.length, (index) {
            return GrocProdCard(
              product: products[index - subcats.length],
              shape: maincat.style,
            );
          }),
        ),
        // GridView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   itemCount: subcats.length + products.length,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     mainAxisExtent: 220,
        //     crossAxisSpacing: 8,
        //     mainAxisSpacing: 8,
        //   ),
        //   itemBuilder: (context, index) {
        //     if (index < subcats.length) {
        //       return GrocSubCatCard(
        //         subCat: subcats[index],
        //         shape: maincat.style,
        //         onTap: () {
        //           // Check if subcategory has items
        //           // For now, we'll show the alert as requested
        //           if (subcats[index].products?.isEmpty ?? false) {
        //             Alerts.showToast(L10n.tr().noItemsAvailableInThisCategory);
        //             return;
        //           }
        //
        //           context.navigateToPage(
        //             SubcategoryItemsScreen(
        //               items: subcats[index].products ?? [],
        //               subcategoryName: subcats[index].name,
        //               vendor: vendor,
        //               maincat: maincat.style,
        //             ),
        //           );
        //         },
        //       );
        //     }
        //     if (index >= subcats.length) {
        //       return GrocProdCard(
        //         product: products[index - subcats.length],
        //         shape: maincat.style,
        //       );
        //     }
        //     return const SizedBox();
        //   },
        // ),
      ],
    );
  }
}
