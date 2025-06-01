import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/option_btn.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/auth/sign_up_screen.dart';

class SelectModeScreen extends StatelessWidget {
  const SelectModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white, gradient: Grad.bgLinear),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.assetsPngShape2),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
            color: Colors.transparent,
          ),

          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(),
            body: Column(
              spacing: 12,
              children: [
                Hero(tag: Tags.character, child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
                GradientText(text: "Select Mode", style: TStyle.blackBold(24), gradient: Grad.radialGradient),
                HorizontalSpacing(double.infinity),
                OptionBtn(onPressed: () {}, text: "Guest Mode", width: 250),
                OptionBtn(onPressed: () {}, text: "Login", width: 250),
                OptionBtn(
                  onPressed: () {
                    context.myPush(SignUpScreen());
                  },
                  text: "Sign Up",
                  width: 250,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
