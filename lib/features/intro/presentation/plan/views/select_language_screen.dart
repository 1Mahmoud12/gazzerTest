import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/intro/presentation/select_mode_screen.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngLanguageShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: Column(
          spacing: 12,
          children: [
            Hero(tag: Tags.character, child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
            GradientText(text: "Select Language", style: TStyle.blackBold(24), gradient: Grad.textGradient),
            const SizedBox(height: 40, width: double.infinity),
            Hero(
              tag: Tags.btn,
              child: OptionBtn(
                onPressed: () {
                  /// change lang to English
                  context.myPush(const SelectModeScreen());
                },

                width: 209,
                child: SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Assets.assetsPngFlagEn, height: 24, width: 24),
                      Text("English", style: TStyle.primarySemi(16)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox.shrink(),
            OptionBtn(
              onPressed: () {
                /// change lang to Arabic
                context.myPush(const SelectModeScreen());
              },

              width: 209,
              child: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Assets.assetsPngFlagEg, height: 24, width: 24),
                    Text("Arabic", style: TStyle.primarySemi(16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
