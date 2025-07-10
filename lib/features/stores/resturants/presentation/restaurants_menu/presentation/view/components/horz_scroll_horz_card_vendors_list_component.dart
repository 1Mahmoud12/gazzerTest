import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/presentation/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/horizontal_vendor_card.dart';

class HorzScrollHorzCardVendorsListComponent extends StatelessWidget {
  const HorzScrollHorzCardVendorsListComponent({super.key, this.corner = Corner.bottomRight, required this.subcat});
  final Corner corner;
  final CategoryOfPlateEntity subcat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Column(
        spacing: 4,
        children: [
          TitleWithMore(title: subcat.name, onPressed: () => context.myPush(const CatRelatedRestaurantsScreen(id: 0))),

          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: Fakers.vendors.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                return HorizontalVendorCard(corner: corner, imgToTextRatio: 0.8, width: 260, vendor: Fakers.vendors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
