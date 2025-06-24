import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/intro/presentation/plan/views/diatery_lifestyle_screen.dart';

class HealthFocusScreen extends StatelessWidget {
  const HealthFocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final focusData = ["Lose Weight", "Build Muscle", "Eat Healthier", "Manage A Condition"];
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
                text: "What Is Your Primary Health Focus",
                style: TStyle.blackBold(20),
                gradient: Grad.textGradient,
              ),
            ),
            const VerticalSpacing(24),
            Column(
              spacing: 16,
              children: [
                ...List.generate(
                  focusData.length,
                  (index) => OptionBtn(
                    onPressed: () {
                      context.myPush(const DiateryLifestyleScreen());
                    },
                    width: 209,
                    height: 60,
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
