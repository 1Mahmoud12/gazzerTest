import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/presentation/views/sign_up_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';

class SelectModeScreen extends StatelessWidget {
  const SelectModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngMoodShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: Column(
          spacing: 12,
          children: [
            Hero(tag: Tags.character, child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
            GradientText(text: "How To Login", style: TStyle.blackBold(24), gradient: Grad.textGradient),
            const SizedBox(height: 40, width: double.infinity),
            Hero(
              tag: Tags.btn,
              child: OptionBtn(
                onPressed: () {
                  context.myPushAndRemoveUntil(const LoadingScreen(navigateTo: MainLayout()));
                },
                text: L10n.tr().guestMode,
                width: 209,
              ),
            ),
            const SizedBox.shrink(),

            OptionBtn(
              onPressed: () {
                context.myPush(const SignUpScreen());
              },
              text: L10n.tr().signUp,
              width: 209,
            ),
          ],
        ),
      ),
    );
  }
}
