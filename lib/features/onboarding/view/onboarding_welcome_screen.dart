import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text_wz_shadow.dart';
import 'package:gazzer/core/presentation/widgets/main_btn.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/auth/views/select_mode_screen.dart';

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.assetsPngOnboardBg), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HorizontalSpacing(double.infinity),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.15,
                      child: Hero(
                        tag: Tags.cloud,
                        child: Image.asset(
                          Assets.assetsPngCloudLogo,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Hero(tag: Tags.character, child: SvgPicture.asset(Assets.assetsSvgCharacter)),
                        GradientTextWzShadow(
                          text: "${L10n.tr().hiIamGazzer}\n${L10n.tr().welcome}",
                          textAlign: TextAlign.center,
                          style: TStyle.mainwBold(38),
                          gradient: Grad.radialGradient,
                          shadow: BoxShadow(
                            color: Co.secondary.withAlpha(125),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ),
                        Text(L10n.tr().niceToMeetYou, style: TStyle.blackSemi(18)),
                        const VerticalSpacing(20),
                      ],
                    ),
                  ],
                ),
                const VerticalSpacing(40),
                MainBtn(
                  onPressed: () {
                    context.myPush(const SelectModeScreen());
                  },
                  text: L10n.tr().letsGo,
                  // width: ,
                  icon: Icons.arrow_forward_ios_outlined,
                  padding: const EdgeInsets.fromLTRB(4,4,12,4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
