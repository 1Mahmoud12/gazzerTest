import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/presentation/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/horizontal_vendor_card.dart';

class HorizontalVendorGridComponent extends StatelessWidget {
  const HorizontalVendorGridComponent({super.key, required this.subCat});
  final CategoryOfPlateEntity subCat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TitleWithMore(title: subCat.name, onPressed: () => context.myPush(const CatRelatedRestaurantsScreen(id: 0))),
          SizedBox(
            height: 300,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: Fakers.vendors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 350, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemBuilder: (context, index) {
                return HorizontalVendorCard(vendor: Fakers.vendors[index], corner: index.isEven ? Corner.bottomLeft : Corner.bottomRight);
              },
            ),
          ),
        ],
      ),
    );
  }
}
