import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/resturants/cat_related_restaurants/presentation/view/cat_related_restaurants_screen.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/vertical_vendor_card.dart';

class HorzScrollVertCardVendorsListComponent extends StatelessWidget {
  const HorzScrollVertCardVendorsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        TitleWithMore(title: '', onPressed: () => context.myPush(const CatRelatedRestaurantsScreen(id: 0))),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: Fakers.vendors.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              return VerticalVendorCard(imgToTextRatio: 0.9, width: 140, vendor: Fakers.vendors[index]);
            },
          ),
        ),
      ],
    );
  }
}
