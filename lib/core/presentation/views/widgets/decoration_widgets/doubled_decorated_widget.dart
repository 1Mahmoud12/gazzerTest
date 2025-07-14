import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class DoubledDecoratedWidget extends StatelessWidget {
  const DoubledDecoratedWidget({super.key, this.innerDecoration, required this.child, this.borderRadius});
  final BoxDecoration? innerDecoration;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? innerDecoration?.borderRadius ?? AppConst.defaultBorderRadius,
        gradient: Grad().radialGradient,
        shape: innerDecoration?.shape ?? BoxShape.rectangle,
      ),
      child: DecoratedBox(
        decoration:
            innerDecoration?.copyWith(borderRadius: borderRadius) ??
            BoxDecoration(borderRadius: borderRadius ?? AppConst.defaultBorderRadius, gradient: Grad().linearGradient),
        child: child,
      ),
    );
  }
}
