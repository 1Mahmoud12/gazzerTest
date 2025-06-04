import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';

class CircleGradientBorderedImage extends StatelessWidget {
  const CircleGradientBorderedImage({super.key, required this.image, this.shadow, this.showBorder = true});
  final String image;
  final BoxShadow? shadow;
  final bool showBorder;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: !showBorder ? null : GradientBoxBorder(gradient: Grad.shadowGrad()),
        boxShadow: shadow == null ? null : [shadow!],
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: ClipOval(
          child: AspectRatio(aspectRatio: 1.0, child: Image.asset(image, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
