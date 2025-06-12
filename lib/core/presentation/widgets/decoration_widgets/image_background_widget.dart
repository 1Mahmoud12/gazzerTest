import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';

class ImageBackgroundWidget extends StatelessWidget {
  const ImageBackgroundWidget({super.key, required this.image, required this.child});
  final String image;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white, gradient: Grad.bgLinear),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
            color: Colors.transparent,
          ),

          child: child,
        ),
      ),
    );
  }
}
