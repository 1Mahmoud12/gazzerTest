import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';

class AddIcon extends StatelessWidget {
  const AddIcon({super.key, this.iconColor, this.radius, required this.onTap, this.padding, this.innterDecoration});
  final Color? iconColor;
  final double? radius;
  final Function() onTap;
  final EdgeInsets? padding;
  final BoxDecoration? innterDecoration;
  @override
  Widget build(BuildContext context) {
    return DoubledDecoratedWidget(
      innerDecoration: innterDecoration,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius ?? 7),
        bottomRight: Radius.circular(radius ?? 7),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(4),
          child: Icon(Icons.add, color: iconColor ?? Co.second2, size: radius ?? 22),
        ),
      ),
    );
  }
}
