import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/intro/presentation/plan/views/diatery_lifestyle_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';
import 'package:go_router/go_router.dart';

class HealthFocusScreen extends StatefulWidget {
  const HealthFocusScreen({super.key});
  static const route = '/health-focus';
  @override
  State<HealthFocusScreen> createState() => _HealthFocusScreenState();
}

class _HealthFocusScreenState extends State<HealthFocusScreen> {
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

  final focusData = ["Lose Weight", "Build Muscle", "Eat Healthier", "Manage A Condition"];
  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngHealthFocusShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: ListView(
          padding: AppConst.defaultHrPadding,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GradientText(
                text: L10n.tr().whatIsYourPrimaryHealthFocus,
                style: TStyle.blackBold(20),
                gradient: Grad().textGradient,
              ),
            ),
            const VerticalSpacing(24),
            Column(
              spacing: 16,
              children: [
                ...List.generate(
                  focusData.length,
                  (index) => PlanAnimatedBtn(
                    isAnimating: isAnimating,
                    animDuration: animDuration,
                    onPressed: () {
                      isAnimating.value = false;
                      context.push(DiateryLifestyleScreen.route).then((v) => isAnimating.value = true);
                    },
                    text: focusData[index],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
