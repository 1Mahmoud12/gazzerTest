import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.style,
    // this.gradient = const RadialGradient(colors: [Co.purple, Co.darkMauve], center: Alignment.center, radius: 1),
    this.gradient,
    this.textAlign = TextAlign.center,
    this.maxLines,
  });
  final String text;
  final TextStyle style;
  final Gradient? gradient;
  final int? maxLines;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return (gradient ?? Grad().textGradient).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        textAlign: textAlign,
        style: style,
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      ),
    );
  }
}
