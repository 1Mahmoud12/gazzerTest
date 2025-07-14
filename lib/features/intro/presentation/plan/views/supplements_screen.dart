import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/intro/presentation/plan/views/nuttration_support_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';

class SupplementsScreen extends StatefulWidget {
  const SupplementsScreen({super.key});

  @override
  State<SupplementsScreen> createState() => _SupplementsScreenState();
}

class _SupplementsScreenState extends State<SupplementsScreen> {
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

  final focusData = ["Yes, Daily", "Occasionally", "No"];

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngSupplementationShape,
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
                text: "Do you take medications or health supplements regularly?",
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
                      context.myPush(const NuttrationSupportScreen()).then((v) {
                        isAnimating.value = true;
                      });
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
