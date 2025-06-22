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
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart'
    show GradientTextWzShadow, HorizontalSpacing, MainBtn, VerticalSpacing;
import 'package:gazzer/features/intro/presentation/plan/views/select_language_screen.dart';

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
            appBar: const ClassicAppBar(),
            body: SafeArea(
              bottom: true,
              top: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HorizontalSpacing(double.infinity),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.65,
                        child: Hero(
                          tag: Tags.cloud,
                          child: Image.asset(Assets.assetsPngCloudLogo, fit: BoxFit.fill, alignment: Alignment.center, color: Colors.white),
                        ),
                      ),
                      Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: Tags.character,
                            child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 195, width: 219, fit: BoxFit.cover),
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topRight,
                            children: [
                              GradientTextWzShadow(
                                text: "${L10n.tr().hiIamGazzer}\n${L10n.tr().welcome}",
                                textAlign: TextAlign.center,
                                style: TStyle.mainwBold(32),
                                gradient: Grad.textGradient,
                                shadow: BoxShadow(color: Co.secondary.withAlpha(125), spreadRadius: 0, blurRadius: 2, offset: const Offset(0, 3)),
                              ),
                              Positioned(top: -35, right: -10, child: Image.asset(Assets.assetsPngWave, height: 40, width: 40)),
                            ],
                          ),
                          Text(L10n.tr().niceToMeetYou, style: TStyle.blackSemi(14)),
                          const VerticalSpacing(20),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpacing(120),
                  MainBtn(
                    onPressed: () {
                      context.myPush(const SelectLanguageScreen());
                    },
                    text: L10n.tr().letsGo,
                    textStyle: TStyle.blackSemi(16).copyWith(color: Co.bg),
                    // width: ,
                    icon: Icons.arrow_forward_ios_rounded,
                    padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
                  ),
                  VerticalSpacing(100 - MediaQuery.paddingOf(context).bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
