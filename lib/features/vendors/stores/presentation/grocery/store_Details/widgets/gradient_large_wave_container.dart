import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/utils/pharmacy_large_wave_shape.dart';

/// Gradient wave container with large wave shape for height 350
class GradientLargeWaveContainer extends StatelessWidget {
  const GradientLargeWaveContainer({super.key, required this.child, this.height = 350, this.padding});

  final Widget child;
  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: PharmacyLargeWaveShape(height: height),
          child: Container(
            height: height,
            width: double.infinity,

            decoration: BoxDecoration(gradient: Grad().pharmacyLinearGrad),
          ),
        ),
        Padding(padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: child),
      ],
    );
  }
}
