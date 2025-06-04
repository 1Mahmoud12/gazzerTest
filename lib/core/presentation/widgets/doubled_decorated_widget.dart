import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class DoubledDecoratedWidget extends StatelessWidget {
  const DoubledDecoratedWidget({super.key, this.innerDecoration, required this.child});
  final BoxDecoration? innerDecoration;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: innerDecoration?.borderRadius ?? AppConst.defaultBorderRadius,
        gradient: Grad.radialGradient,
      ),
      child: DecoratedBox(
        decoration:
            innerDecoration ?? BoxDecoration(borderRadius: AppConst.defaultBorderRadius, gradient: Grad.linearGradient),
        child: child,
      ),
    );
  }
}
