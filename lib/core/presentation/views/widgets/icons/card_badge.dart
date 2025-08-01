import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';

class CardBadge extends StatelessWidget {
  const CardBadge({super.key, this.alignment, required this.text, this.textStyle, this.color, this.fullWidth = false});
  final AlignmentDirectional? alignment;
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final bool fullWidth;
  @override
  Widget build(BuildContext context) {
    final child = ColoredBox(
      color: color ?? Co.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Text(text, style: textStyle ?? TStyle.primaryBold(12)),
          ],
        ),
      ),
    );
    if (alignment != null) {
      return Align(
        alignment: AlignmentDirectional.topStart,
        child: child,
      );
    }
    return child;
  }
}
