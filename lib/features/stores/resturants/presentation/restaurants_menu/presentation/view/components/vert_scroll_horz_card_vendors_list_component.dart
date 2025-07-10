import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/presentation/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/horizontal_vendor_card.dart';

class VertScrollHorzCardVendorsListComponent extends StatelessWidget {
  const VertScrollHorzCardVendorsListComponent({super.key, required this.subcat});
  final CategoryOfPlateEntity subcat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Column(
        spacing: 4,
        children: [
          TitleWithMore(title: subcat.name, onPressed: () => context.myPush(const CatRelatedRestaurantsScreen(id: 0))),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: Fakers.vendors.length,
            separatorBuilder: (context, index) => const VerticalSpacing(12),
            itemBuilder: (context, index) {
              return HorizontalVendorCard(
                imgToTextRatio: 1.4,
                // width: 350,
                height: 115,
                vendor: Fakers.vendors[index],
                corner: Corner.topLeft,
              );
            },
          ),
        ],
      ),
    );
  }
}
