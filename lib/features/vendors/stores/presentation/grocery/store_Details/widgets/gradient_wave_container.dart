import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/utils/header_shape.dart';

/// Reusable gradient container with wave shape for store details
class GradientWaveContainer extends StatelessWidget {
  const GradientWaveContainer({super.key, required this.child, this.height = 200, this.padding});

  final Widget child;
  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Background with Custom Wave Shape
        ClipPath(
          clipper: PharmacyHeaderShape(height: height),
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(gradient: Grad().pharmacyLinearGrad),
          ),
        ),

        // Content
        SafeArea(
          child: Padding(padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: child),
        ),
      ],
    );
  }
}
