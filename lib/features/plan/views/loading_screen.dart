import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/staggered_dots_wave.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/shaped_bg_widget.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/plan/views/congrats_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        context.myPushAndRemoveUntil(const CongratsScreen());
      }
    });
    return ShapedBgWidget(
      shape: Assets.assetsPngShape5,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            const HorizontalSpacing(double.infinity),
            GradientText(text: L10n.tr().loading, style: TStyle.blackBold(24), gradient: Grad.radialGradient),
            StaggeredDotsWave(
              colors: [Co.tertiary, Co.purple, Co.greyText, Co.secondary, Co.secondary],
              size: 100,
              dotsNumber: 5,
            ),
          ],
        ),
      ),
    );
  }
}
