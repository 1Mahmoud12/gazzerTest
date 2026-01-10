import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, VerticalSpacing;
import 'package:gazzer/features/intro/presentation/plan/views/health_focus_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';
import 'package:go_router/go_router.dart';

class ChooseYourMode extends StatefulWidget {
  const ChooseYourMode({super.key});
  static const route = '/choose-mode';

  @override
  State<ChooseYourMode> createState() => _ChooseYourModeState();
}

class _ChooseYourModeState extends State<ChooseYourMode> {
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
    final moods = [L10n.tr().happy, L10n.tr().sad, L10n.tr().excited, L10n.tr().bored, L10n.tr().angry];
    final emojis = ['\u{1F60A}', '\u{1F622}', '\u{1F603}', '\u{1F62B}', '\u{1F621}'];
    return ImageBackgroundWidget(
      image: Assets.assetsPngChooseMoodShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: ListView(
          padding: AppConst.defaultHrPadding,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            GradientText(text: '${L10n.tr().chooseYourMood}\n', style: context.style20500, gradient: Grad().textGradient),
            const VerticalSpacing(24),
            Column(
              spacing: 16,
              children: [
                Hero(
                  tag: Tags.btn,
                  child: PlanAnimatedBtn(
                    onPressed: () {
                      isAnimating.value = false;
                      context.push(HealthFocusScreen.route).then((v) => isAnimating.value = true);
                    },
                    isAnimating: isAnimating,
                    animDuration: animDuration,
                    child: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(emojis.first, style: const TextStyle(fontSize: 28)),
                          Text(moods[0], style: context.style16500.copyWith(color: Co.purple)),
                        ],
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  moods.length - 1,
                  (index) => PlanAnimatedBtn(
                    onPressed: () {
                      isAnimating.value = false;
                      context.push(HealthFocusScreen.route).then((v) => isAnimating.value = true);
                    },
                    isAnimating: isAnimating,
                    animDuration: animDuration,
                    child: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(emojis[index + 1], style: const TextStyle(fontSize: 28)),
                          Text(moods[index + 1], style: context.style16500.copyWith(color: Co.purple)),
                        ],
                      ),
                    ),
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
