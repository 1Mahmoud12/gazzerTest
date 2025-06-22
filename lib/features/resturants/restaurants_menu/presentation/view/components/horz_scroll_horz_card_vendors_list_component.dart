import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/resturants/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/horizontal_vendor_card.dart';

class HorzScrollHorzCardVendorsListComponent extends StatelessWidget {
  const HorzScrollHorzCardVendorsListComponent({super.key, this.corner = Corner.bottomRight, required this.subcat});
  final Corner corner;
  final SubcategoryModel subcat;
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
