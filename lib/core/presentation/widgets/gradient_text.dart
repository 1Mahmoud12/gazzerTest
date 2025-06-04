import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.style,
    this.gradient = const RadialGradient(colors: [Co.mauve, Co.darkMauve], center: Alignment.center, radius: 0.7),
    this.textAlign = TextAlign.center,
  });
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(text, textAlign: textAlign, style: style),
    );
  }
}
