import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';

class AddIcon extends StatelessWidget {
  const AddIcon({
    super.key,
    this.iconColor,
    this.radius,
    required this.onTap,
    this.padding,
    this.innterDecoration,
    this.isLoading = false,
  });
  final Color? iconColor;
  final double? radius;
  final Function() onTap;
  final EdgeInsets? padding;
  final BoxDecoration? innterDecoration;
  final bool isLoading;
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
          child: isLoading
              ? const AdaptiveProgressIndicator(
                  size: 22,
                  color: Co.secondary,
                )
              : Icon(Icons.add, color: iconColor ?? Co.secondary, size: radius ?? 22),
        ),
      ),
    );
  }
}
