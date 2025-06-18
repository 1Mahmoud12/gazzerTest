import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/vertical_vendor_card.dart';

class VerticalVendorGridComponent extends StatelessWidget {
  const VerticalVendorGridComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: Fakers.vendors.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 220,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return VerticalVendorCard(width: 350, height: 150, vendor: Fakers.vendors[index], corner: Corner.bottomLeft);
      },
    );
  }
}
