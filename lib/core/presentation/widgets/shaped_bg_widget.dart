import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';

class ShapedBgWidget extends StatelessWidget {
  const ShapedBgWidget({super.key, required this.shape, required this.child});
  final String shape;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white, gradient: Grad.bgLinear),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(shape), fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
            color: Colors.transparent,
          ),

          child: child,
        ),
      ),
    );
  }
}
