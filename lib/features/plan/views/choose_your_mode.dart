import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/widgets/helper_widgets/helper_widgets.dart'
    show GradientText, VerticalSpacing, OptionBtn;
import 'package:gazzer/features/plan/views/loading_screen.dart';

class ChooseYourMode extends StatelessWidget {
  const ChooseYourMode({super.key});

  @override
  Widget build(BuildContext context) {
    final moods = [L10n.tr().happy, L10n.tr().sad, L10n.tr().excited, L10n.tr().bored, L10n.tr().angry];
    final emojis = ["\u{1F60A}", "\u{1F622}", "\u{1F603}", "\u{1F610}", "\u{1F620}"];
    return ImageBackgroundWidget(
      image: Assets.assetsPngShape4,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: ListView(
          padding: AppConst.defaultHrPadding,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            GradientText(text: L10n.tr().chooseYourMood, style: TStyle.blackBold(24), gradient: Grad.radialGradient),
            const VerticalSpacing(24),
            Column(
              spacing: 16,
              children: [
                Hero(
                  tag: Tags.btn,
                  child: OptionBtn(
                    onPressed: () {
                      context.myPushAndRemoveUntil(const LoadingScreen());
                    },
                    width: 250,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(emojis.first, style: const TextStyle(fontSize: 24)),
                          Text(moods[0], style: TStyle.blackSemi(18)),
                        ],
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  moods.length - 1,
                  (index) => OptionBtn(
                    onPressed: () {
                      context.myPushAndRemoveUntil(const LoadingScreen());
                    },
                    width: 250,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(emojis[index + 1], style: const TextStyle(fontSize: 24)),
                          Text(moods[index + 1], style: TStyle.blackSemi(18)),
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
