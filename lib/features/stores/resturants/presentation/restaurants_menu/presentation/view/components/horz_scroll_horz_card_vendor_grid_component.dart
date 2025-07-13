import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';
import 'package:gazzer/features/stores/resturants/presentation/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/horizontal_vendor_card.dart';

class HorizontalVendorGridComponent extends StatelessWidget {
  const HorizontalVendorGridComponent({super.key, required this.catName, required this.catId, required this.rests});
  final String catName;
  final int catId;
  final List<RestaurantEntity> rests;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TitleWithMore(
            title: catName,
            onPressed: () => context.myPush(CatRelatedRestaurantsScreen(id: catId)),
          ),
          SizedBox(
            height: 300,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: Fakers.vendors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 350, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemBuilder: (context, index) {
                return HorizontalVendorCard(vendor: rests[index], corner: index.isEven ? Corner.bottomLeft : Corner.bottomRight);
              },
            ),
          ),
        ],
      ),
    );
  }
}
