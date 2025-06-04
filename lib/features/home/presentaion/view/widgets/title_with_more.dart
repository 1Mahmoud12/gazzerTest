import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';

class TitleWithMore extends StatelessWidget {
  const TitleWithMore({super.key, required this.title, this.titleStyle, this.showMore = true, this.onPressed});
  final String title;
  final TextStyle? titleStyle;
  final bool showMore;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GradientText(
          text: title,
          style: titleStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          gradient: Grad.radialGradient,
        ),
        if (showMore)
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(backgroundColor: Co.secondary.withAlpha(25), elevation: 0),
            child: Text("View All", style: TStyle.primarySemi(16)),
          ),
      ],
    );
  }
}
