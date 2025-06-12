import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import  'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';

class PostCheckoutScreen extends StatelessWidget {
  const PostCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: Grad.bgLinear.copyWith(colors: [Co.purple.withAlpha(80), Co.bg.withAlpha(0)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        SystemSound.play(SystemSoundType.click);
                        context.myPushAndRemoveUntil(const MainLayout());
                      },
                      icon: const Icon(Icons.home_outlined, size: 32, color: Co.purple),
                    ),
                    IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.location_pin, size: 32, color: Co.purple),
                    ),
                    const Spacer(),
                    SvgPicture.asset(Assets.assetsSvgCharacter, height: 80),
                  ],
                ),
                Expanded(
                  child: Column(
                    spacing: 32,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.assetsSvgSuccess),
                      GradientText(text:  "Order Placed Successfully!", style: TStyle.blackBold(22)),
                      const VerticalSpacing(64),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
