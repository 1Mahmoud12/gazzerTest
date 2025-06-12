import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/views/sign_up_screen.dart';
import 'package:gazzer/features/main_layout/views/main_layout.dart';

class SelectModeScreen extends StatelessWidget {
  const SelectModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngShape2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Column(
          spacing: 12,
          children: [
            Hero(tag: Tags.character, child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
            GradientText(text: L10n.tr().selectMode, style: TStyle.blackBold(24), gradient: Grad.radialGradient),
            const HorizontalSpacing(double.infinity),
            Hero(
              tag: Tags.btn,
              child: OptionBtn(
                onPressed: () {
                  context.myPushAndRemoveUntil(const MainLayout());
                },
                text: L10n.tr().guestMode,
                width: 250,
              ),
            ),
            OptionBtn(onPressed: () {}, text: L10n.tr().signIn, width: 250),
            OptionBtn(
              onPressed: () {
                context.myPush(const SignUpScreen());
              },
              text: L10n.tr().signUp,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
