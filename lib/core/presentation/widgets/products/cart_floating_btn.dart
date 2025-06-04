import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/main_text_field.dart';

class CartFloatingBtn extends StatelessWidget {
  const CartFloatingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: Grad.radialGradient),
        child: DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: Grad.linearGradient),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset(Assets.assetsSvgCart, height: 25, width: 25),
          ),
        ),
      ),
    );
  }
}
