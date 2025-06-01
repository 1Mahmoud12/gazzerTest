import 'package:flutter/material.dart';

class GradientTextWzShadow extends StatelessWidget {
  const GradientTextWzShadow({
    super.key,
    required this.text,
    required this.gradient,
    required this.shadow,
    this.style = const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
    required this.textAlign,
  });
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final BoxShadow shadow;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: text, style: style);
        //  TODO : make text direction dynamic
        final textPainter = TextPainter(text: span, textDirection: TextDirection.ltr, textAlign: textAlign);
        textPainter.layout(maxWidth: constraints.maxWidth);
        final lines = textPainter.computeLineMetrics().length;
        return SizedBox(
          height: textPainter.size.height + ((lines) * ((style.fontSize ?? 48) * 0.2)),
          // width: textPainter.size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Shadow text
              Text(
                text,
                textAlign: textAlign,
                style: style.copyWith(shadows: [shadow]),
              ),

              // Foreground gradient text
              ShaderMask(
                shaderCallback: (bounds) {
                  return gradient.createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Text(text, textAlign: textAlign, style: style),
              ),
            ],
          ),
        );
      },
    );
  }
}
