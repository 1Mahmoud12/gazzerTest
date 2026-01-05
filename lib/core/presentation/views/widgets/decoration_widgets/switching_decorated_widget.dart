import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SwitchingDecoratedwidget extends StatelessWidget {
  const SwitchingDecoratedwidget({super.key, required this.isDarkContainer, this.borderRadius, required this.child});
  final bool isDarkContainer;
  final BorderRadiusGeometry? borderRadius;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (isDarkContainer) {
      return Skeleton.shade(
        child: DoubledDecoratedWidget(
          innerDecoration: BoxDecoration(borderRadius: borderRadius ?? BorderRadiusGeometry.circular(12), gradient: Grad().linearGradient),

          child: child,
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        // border: GradientBoxBorder(gradient: Grad().shadowGrad()),
        borderRadius: borderRadius ?? BorderRadiusGeometry.circular(12),
        color: Co.purple,
        //  gradient: Grad().bgLinear.copyWith(stops: const [0.0, 1], colors: [const Color(0x55402788), Colors.transparent]),
      ),
      child: child,
    );
  }
}
