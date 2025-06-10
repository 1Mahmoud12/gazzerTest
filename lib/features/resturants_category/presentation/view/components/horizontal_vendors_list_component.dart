import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/resturants_category/presentation/view/widgets/horizontal_vendor_card.dart';

class HorizontalVendorsListComponent extends StatelessWidget {
  const HorizontalVendorsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: Fakers.vendors.length,
        separatorBuilder: (context, index) => const HorizontalSpacing(12),
        itemBuilder: (context, index) {
          return HorizontalVendorCard(width: 300, vendor: Fakers.vendors[index]);
        },
      ),
    );
  }
}
