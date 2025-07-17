import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/intro/presentation/congrats_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';

class FrequancyCombosScreen extends StatefulWidget {
  const FrequancyCombosScreen({super.key});
  static const route = '/frequancy-combo';
  @override
  State<FrequancyCombosScreen> createState() => _FrequancyCombosScreenState();
}

class _FrequancyCombosScreenState extends State<FrequancyCombosScreen> {
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

  final focusData = ["Every 3 days", "weely", "I'll Choose Manually"];
  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngFrequencyShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: ListView(
          padding: AppConst.defaultHrPadding,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GradientText(
                text: "How often would you like to receive your healthy combos?",
                style: TStyle.blackBold(20),
                gradient: Grad().textGradient,
              ),
            ),
            const VerticalSpacing(24),
            Column(
              spacing: 16,
              children: [
                ...List.generate(focusData.length, (index) {
                  final child = PlanAnimatedBtn(
                    onPressed: () async {
                      isAnimating.value = false;
                      const LoadingScreenRoute(navigateToRoute: '').go(context);
                      await Future.delayed(const Duration(seconds: 3));
                      const CongratsScreenRoute(navigateToRoute: HomeScreen.route).go(context);
                    },
                    isAnimating: isAnimating,
                    animDuration: animDuration,
                    text: focusData[index],
                  );
                  if (index == 0) {
                    return Hero(tag: Tags.btn, child: child);
                  }
                  return child;
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
