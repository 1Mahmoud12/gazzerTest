import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';

class CartFloatingBtn extends StatelessWidget {
  const CartFloatingBtn({super.key, this.size = 25, this.padding = 12});
  final double size;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Tags.cart,
      child: GestureDetector(
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          AppNavigator().push(const CartScreen());
        },
        child: DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: Grad.radialGradient),
          child: DecoratedBox(
            decoration: BoxDecoration(shape: BoxShape.circle, gradient: Grad.linearGradient),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: SvgPicture.asset(Assets.assetsSvgCart, height: size, width: size),
            ),
          ),
        ),
      ),
    );
  }
}
