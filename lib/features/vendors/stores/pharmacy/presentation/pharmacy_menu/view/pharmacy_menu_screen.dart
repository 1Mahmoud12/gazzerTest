import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/vendors/stores/pharmacy/presentation/utils/header_shape.dart';

class PharmacyMenuScreen extends StatelessWidget {
  const PharmacyMenuScreen({super.key});
  static const route = '/pharmacy-menu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: PharmacyHeaderShape(),
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: Grad().pharmacyLinearGrad, color: Colors.red),
              child: SizedBox(
                height: 200,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
