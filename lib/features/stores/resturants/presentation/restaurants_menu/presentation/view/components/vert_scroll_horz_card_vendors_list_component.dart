import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';
import 'package:gazzer/features/stores/resturants/presentation/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/horizontal_vendor_card.dart';

class VertScrollHorzCardVendorsListComponent extends StatelessWidget {
  const VertScrollHorzCardVendorsListComponent({super.key, required this.catName, required this.catId, required this.rests});
  final String catName;
  final int catId;
  final List<RestaurantEntity> rests;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Column(
        spacing: 4,
        children: [
          TitleWithMore(
            title: catName,
            onPressed: () => CatRelatedRestaurantsRoute(id: catId).push(context),
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: rests.length,
            separatorBuilder: (context, index) => const VerticalSpacing(12),
            itemBuilder: (context, index) {
              return HorizontalVendorCard(
                imgToTextRatio: 1.4,
                // width: 350,
                height: 115,
                vendor: rests[index],
                corner: Corner.topLeft,
              );
            },
          ),
        ],
      ),
    );
  }
}
