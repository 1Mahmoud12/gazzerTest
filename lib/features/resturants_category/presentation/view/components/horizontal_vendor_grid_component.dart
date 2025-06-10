import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/resturants_category/presentation/view/widgets/horizontal_vendor_card.dart';

class HorizontalVendorGridComponent extends StatelessWidget {
  const HorizontalVendorGridComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: Fakers.vendors.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 350,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return HorizontalVendorCard(
            vendor: Fakers.vendors[index],
            corner: index.isEven ? Corner.bottomLeft : Corner.bottomRight,
          );
        },
      ),
    );
  }
}
