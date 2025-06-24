import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, HorizontalSpacing, OptionBtn;
import 'package:gazzer/features/intro/presentation/congrats_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/choose_your_mode.dart';

class HealthyPlanScreen extends StatelessWidget {
  const HealthyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngSetPlanShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: Column(
          spacing: 12,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            GradientText(text: L10n.tr().healthyPlan, style: TStyle.blackBold(20), gradient: Grad.textGradient),
            SizedBox(
              width: 250,
              child: Text(L10n.tr().thisPartHelpYouToBeMoreHealthy, style: TStyle.blackSemi(18), textAlign: TextAlign.center),
            ),
            Hero(
              tag: Tags.btn,
              child: OptionBtn(
                onPressed: () {
                  context.myPush(const ChooseYourMode());
                },
                width: 209,
                text: L10n.tr().setHealthPlan,
              ),
            ),
            OptionBtn(
              onPressed: () {
                context.myPush(const CongratsScreen(navigateTo: MainLayout()));
              },
              text: L10n.tr().skip,
              width: 209,
            ),
            const HorizontalSpacing(double.infinity),
          ],
        ),
      ),
    );
  }
}
