import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import  'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/resturants/resturants_category/presentation/view/widgets/horizontal_vendor_card.dart';

class VertScrollHorzCardVendorsListComponent extends StatelessWidget {
  const VertScrollHorzCardVendorsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        const TitleWithMore(title: ''),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}
