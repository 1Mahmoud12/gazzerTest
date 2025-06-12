import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/widgets/title_with_more.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/vertical_vendor_card.dart';

class HorzScrollVertCardVendorsListComponent extends StatelessWidget {
  const HorzScrollVertCardVendorsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        const TitleWithMore(title: ''),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: Fakers.vendors.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              return VerticalVendorCard(
                imgToTextRatio: 0.9,
                width: 140, vendor: Fakers.vendors[index]);
            },
          ),
        ),
      ],
    );
  }
}
