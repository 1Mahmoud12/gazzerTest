import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';

class ReturnLogoVendor extends StatelessWidget {
  const ReturnLogoVendor({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return VectorGraphicsWidget(
      type == VendorType.restaurant.value
          ? Assets.restaurantNameIc
          : type == VendorType.pharmacy.value
          ? Assets.pharmacyStoreIc
          : Assets.restaurantNameIc,
    );
  }
}
