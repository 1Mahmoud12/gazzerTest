import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:go_router/go_router.dart';

class MainCartWidget extends StatelessWidget {
  const MainCartWidget({
    super.key,
    this.size = 25,
    this.padding = 12,
    this.navigate = true,
    this.showBadge = false,
  });
  final double size;
  final double padding;
  final bool navigate;
  final bool showBadge;
  @override
  Widget build(BuildContext context) {
    final child = Hero(
      tag: Tags.cart,
      child: GestureDetector(
        onTap: () {
          if (!navigate) return;
          SystemSound.play(SystemSoundType.click);
          if (navigate) context.push(CartScreen.route);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: Grad().radialGradient,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: Grad().linearGradient,
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: SvgPicture.asset(
                Assets.assetsSvgCart,
                height: size,
                width: size,
              ),
            ),
          ),
        ),
      ),
    );
    if (showBadge) {
      return StreamBuilder(
        stream: di<CartBus>().getStream<GetCartEvents>(),
        builder: (context, snapshot) => Badge(
          label: Text(
            di<CartBus>().vendors
                .fold(
                  0,
                  (previousValue, element) =>
                      previousValue +
                      element.items.fold<int>(
                        0,
                        (previousValue, item) => previousValue + item.quantity,
                      ),
                )
                .toString(),
          ),
          isLabelVisible:
              di<CartBus>().vendors.fold(
                0,
                (previousValue, element) =>
                    previousValue +
                    element.items.fold<int>(
                      0,
                      (previousValue, item) => previousValue + item.quantity,
                    ),
              ) >
              0,
          textColor: Co.mainText,
          backgroundColor: Co.second2,
          child: child,
        ),
      );
    } else {
      return child;
    }
  }
}
