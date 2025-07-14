import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, HorizontalSpacing;
import 'package:gazzer/features/intro/presentation/congrats_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/choose_your_mode.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';

class HealthyPlanScreen extends StatefulWidget {
  const HealthyPlanScreen({super.key});

  @override
  State<HealthyPlanScreen> createState() => _HealthyPlanScreenState();
}

class _HealthyPlanScreenState extends State<HealthyPlanScreen> {
  final isAnimating = ValueNotifier<bool>(false);
  final animDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isAnimating.value = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    isAnimating.dispose();
    super.dispose();
  }

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
            GradientText(text: L10n.tr().healthyPlan, style: TStyle.blackBold(20), gradient: Grad().textGradient),
            SizedBox(
              width: 250,
              child: Text(
                L10n.tr().thisPartHelpYouToBeMoreHealthy,
                style: TStyle.blackSemi(18),
                textAlign: TextAlign.center,
              ),
            ),
            PlanAnimatedBtn(
              onPressed: () {
                isAnimating.value = false;
                context.myPush(const ChooseYourMode()).then((v) {
                  isAnimating.value = true;
                });
              },
              text: L10n.tr().setHealthPlan,
              isAnimating: isAnimating,
              animDuration: animDuration,
            ),
            Hero(
              tag: Tags.btn,
              child: PlanAnimatedBtn(
                onPressed: () {
                  context.myPushAndRemoveUntil(const CongratsScreen(navigateTo: MainLayout()));
                },
                text: L10n.tr().skip,
                isAnimating: isAnimating,
                animDuration: animDuration,
              ),
            ),
            const HorizontalSpacing(double.infinity),
          ],
        ),
      ),
    );
  }
}
