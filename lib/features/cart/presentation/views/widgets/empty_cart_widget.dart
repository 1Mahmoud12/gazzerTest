import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:go_router/go_router.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: Grad().bglightLinear),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Image.asset(Assets.nothingInCartIc, fit: BoxFit.contain),
              ),
            ),
            const VerticalSpacing(16),

            Text(L10n.tr().nothing_here_yet, style: context.style24500, textAlign: TextAlign.center),
            const VerticalSpacing(16),

            Text(L10n.tr().add_items_to_cart_to_continue_order, style: context.style16500, textAlign: TextAlign.center),
            const VerticalSpacing(16),
            MainBtn(
              onPressed: () {
                context.go(HomeScreen.route);
              },

              radius: 12,
              text: L10n.tr().start_ordering,
            ),
            const VerticalSpacing(80),
          ],
        ),
      ),
    );
  }
}
