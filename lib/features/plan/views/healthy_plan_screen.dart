import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/widgets/helper_widgets/helper_widgets.dart'
    show GradientText, HorizontalSpacing, OptionBtn;
import 'package:gazzer/features/plan/views/choose_your_mode.dart';

class HealthyPlanScreen extends StatelessWidget {
  const HealthyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngShape3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Column(
          spacing: 12,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            GradientText(text: L10n.tr().healthyPlan, style: TStyle.blackBold(24), gradient: Grad.radialGradient),
            SizedBox(
              width: 250,
              child: Text(
                L10n.tr().thisPartHelpYouToBeMoreHealthy,
                style: TStyle.blackSemi(18),
                textAlign: TextAlign.center,
              ),
            ),
            const HorizontalSpacing(double.infinity),
            Hero(
              tag: Tags.btn,
              child: OptionBtn(
                onPressed: () {
                  context.myPush(const ChooseYourMode());
                },
                text: L10n.tr().setHealthPlan,
                width: 250,
              ),
            ),
            OptionBtn(onPressed: () {}, text: L10n.tr().skip, width: 250),
          ],
        ),
      ),
    );
  }
}
