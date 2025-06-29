import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/resturants/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/vertical_vendor_card.dart';

class VerticalVendorGridComponent extends StatelessWidget {
  const VerticalVendorGridComponent({super.key, required this.subCat});
  final SubcategoryModel subCat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Column(
        children: [
          TitleWithMore(title: subCat.name, onPressed: () => context.myPush(const CatRelatedRestaurantsScreen(id: 0))),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),

            itemCount: Fakers.vendors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 220, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              return VerticalVendorCard(width: 350, height: 150, vendor: Fakers.vendors[index], corner: Corner.bottomLeft);
            },
          ),
        ],
      ),
    );
  }
}
