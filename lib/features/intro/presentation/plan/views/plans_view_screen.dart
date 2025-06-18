import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/option_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/intro/presentation/congrats_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/intro_video_tutorial_screen.dart';

class PlansViewScreen extends StatelessWidget {
  const PlansViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngPlanView,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GradientText(
                text: "Your Plan To Optimize Calories",
                style: TStyle.blackBold(20),
                gradient: Grad.textGradient,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: AppConst.defaultPadding,
                itemCount: 4,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 270,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(gradient: Grad.bglightLinear, borderRadius: AppConst.defaultBorderRadius),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Weight Loss Plan", style: TStyle.primaryBold(16)),
                          const VerticalSpacing(8),
                          Text(
                            "Daily Calorie Range: 1200–1500 kcal (adjusted based on user data)\nFeatures:",
                            style: TStyle.blackRegular(12),
                          ),
                          // const TextSpan(text: "\n"),
                          ...List.generate(
                            4,
                            (index) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const HorizontalSpacing(4),
                                Text("• ", style: TStyle.blackRegular(12)),
                                Expanded(child: Text("Low-carb, high-protein meals", style: TStyle.blackRegular(12))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            OptionBtn(
              onPressed: () {
                context.myPushReplacment(
                  const LoadingScreen(
                    navigateTo: CongratsScreen(navigateTo: IntroVideoTutorialScreen(videoLink: '')),
                  ),
                );
              },
              width: 209,
              text: "Continue",
            ),
            const VerticalSpacing(60),
          ],
        ),
      ),
    );
  }
}
