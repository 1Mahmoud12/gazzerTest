import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.style,
    // this.gradient = const RadialGradient(colors: [Co.purple, Co.darkMauve], center: Alignment.center, radius: 1),
    this.gradient,
    this.textAlign = TextAlign.center,
  });
  final String text;
  final TextStyle style;
  final Gradient? gradient;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    final linear = LinearGradient(
      colors: [Co.lightPurple, Co.darkPurple.withAlpha(201), Co.darkPurple.withAlpha(0)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.07, 0.79, 1.0],
    );

    final radial = gradient ?? const RadialGradient(colors: [Co.mauve, Co.darkMauve], center: Alignment.center, radius: 0.7);
    ;
    return ShaderMask(
      shaderCallback: (bounds) {
        return radial.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(text, textAlign: textAlign, style: style),
    );
  }
}
