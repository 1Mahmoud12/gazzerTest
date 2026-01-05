import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
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
  static const route = '/plans';
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
              child: GradientText(text: L10n.tr().yourPlanToOptimizeCalories, style: TStyle.robotBlackSubTitle(), gradient: Grad().textGradient),
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
                    decoration: BoxDecoration(gradient: Grad().bglightLinear, borderRadius: AppConst.defaultBorderRadius),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: L10n.tr().weightLossPlan,
                              style: TStyle.robotBlackRegular().copyWith(color: Co.purple),
                            ),
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text: 'Daily Calorie Range: 1200–1500 kcal (adjusted based on user data)\nFeatures:',
                              style: TStyle.blackRegular(12),
                            ),
                            const TextSpan(text: '\n'),

                            ...List.generate(4, (i) => TextSpan(text: '\n•  Low-carb, high-protein meals', style: TStyle.blackRegular(12))),
                          ],
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  );
                },
              ),
            ),
            Hero(
              tag: Tags.btn,
              child: OptionBtn(
                onPressed: () async {
                  const LoadingScreenRoute(navigateToRoute: '').go(context);
                  await Future.delayed(const Duration(seconds: 3));
                  const CongratsScreenRoute(navigateToRoute: IntroVideoTutorialScreen.routeUriLink).go(context);
                },
                width: 209,
                text: L10n.tr().continu,
              ),
            ),
            const VerticalSpacing(60),
          ],
        ),
      ),
    );
  }
}
