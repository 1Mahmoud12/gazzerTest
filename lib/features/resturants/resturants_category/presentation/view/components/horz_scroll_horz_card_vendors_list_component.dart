import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import  'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/horizontal_vendor_card.dart';

class HorzScrollHorzCardVendorsListComponent extends StatelessWidget {
  const HorzScrollHorzCardVendorsListComponent({super.key, this.corner = Corner.bottomRight});
  final Corner corner;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        const TitleWithMore(title: ''),

        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: Fakers.vendors.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              return HorizontalVendorCard(
                corner: corner,
                imgToTextRatio: 0.8,
                width: 260,
                vendor: Fakers.vendors[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
