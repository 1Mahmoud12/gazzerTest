import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart'
    show GradientText, HorizontalSpacing, OptionBtn;
import 'package:gazzer/features/plan/presentation/views/choose_your_mode.dart';
import 'package:gazzer/features/plan/presentation/views/congrats_screen.dart';
import 'package:gazzer/features/plan/presentation/views/loading_screen.dart';

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
            GradientText(text: L10n.tr().healthyPlan, style: TStyle.blackBold(20)),
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
                width: 209,
                child: GradientText(text: L10n.tr().setHealthPlan, style: TStyle.blackSemi(16)),
              ),
            ),
            OptionBtn(
              onPressed: () {
                context.myPush(const LoadingScreen(navigateTo: CongratsScreen()));
              },
              text: L10n.tr().skip,
              width: 209,
              child: GradientText(text: L10n.tr().skip, style: TStyle.blackSemi(16)),
            ),
          ],
        ),
      ),
    );
  }
}
