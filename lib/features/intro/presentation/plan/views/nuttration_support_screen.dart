import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/intro/presentation/plan/views/frequancy_combos_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';

class NuttrationSupportScreen extends StatefulWidget {
  const NuttrationSupportScreen({super.key});

  @override
  State<NuttrationSupportScreen> createState() => _NuttrationSupportScreenState();
}

class _NuttrationSupportScreenState extends State<NuttrationSupportScreen> {
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

  final focusData = [
    "Healthy meal\nsuggestions",
    "Grocery combos \nfor meal prep",
    " Vitamins &\nsupplements",
    "Quick prep or ready\nto eat options",
  ];
  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngNutrationShape,
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
                text: "What types of nutrition support would you like?",
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
                    onPressed: () {
                      isAnimating.value = false;
                      context.myPush(const FrequancyCombosScreen()).then((v) {
                        isAnimating.value = true;
                      });
                    },
                    textStyle: TStyle.primarySemi(15),
                    isAnimating: isAnimating,
                    animDuration: animDuration,
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
