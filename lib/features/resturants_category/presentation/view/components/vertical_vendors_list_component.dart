import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/resturants_category/presentation/view/widgets/horizontal_vendor_card.dart';

class VerticalVendorsListComponent extends StatelessWidget {
  const VerticalVendorsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: Fakers.vendors.length,
      separatorBuilder: (context, index) => const VerticalSpacing(12),
      itemBuilder: (context, index) {
        return HorizontalVendorCard(width: 350, height: 150, vendor: Fakers.vendors[index], corner: Corner.topLeft);
      },
    );
  }
}
