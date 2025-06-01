import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text_wz_shadow.dart';
import 'package:gazzer/core/presentation/widgets/main_btn.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(
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
                HorizontalSpacing(double.infinity),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: Tags.cloud,
                      child: SizedBox(height: 500, child: Image.asset(Assets.assetsPngCloudWelcome, fit: BoxFit.cover)),
                    ),
                    Column(
                      spacing: 20,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Assets.assetsSvgCharacter),
                        GradientTextWzShadow(
                          text: "Hi Iam Gazzer\nWelcome",
                          textAlign: TextAlign.center,
                          style: TStyle.mainwBold(42),
                          gradient: Grad.radialGradient,
                          shadow: BoxShadow(
                            color: Co.secondary.withAlpha(125),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ),
                        Text('Nice To meet You', style: TStyle.blackSemi(18)),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                MainBtn(
                  onPressed: () {},
                  text: "Let's Go",
                  // width: ,
                  icon: Icons.arrow_forward_ios_outlined,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
