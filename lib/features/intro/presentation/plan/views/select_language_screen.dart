import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';
import 'package:gazzer/features/intro/presentation/select_mode_screen.dart';
import 'package:go_router/go_router.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});
  static const route = '/language';
  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
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
            GradientText(text: L10n.tr().selectLanguage, style: TStyle.blackBold(24), gradient: Grad().textGradient),
            const SizedBox(height: 40, width: double.infinity),
            PlanAnimatedBtn(
              onPressed: () {
                /// change lang to English
                isAnimating.value = false;
                context.push(SelectModeScreen.route).then((v) => isAnimating.value = true);
              },

              isAnimating: isAnimating,
              animDuration: animDuration,
              child: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Assets.assetsPngFlagEn, height: 24, width: 24),
                    Text(L10n.tr().english, style: TStyle.primarySemi(16)),
                  ],
                ),
              ),
            ),
            const SizedBox.shrink(),
            PlanAnimatedBtn(
              onPressed: () {
                // TODO: change lang to Arabic
                isAnimating.value = false;
                context.push(SelectModeScreen.route).then((v) => isAnimating.value = true);
              },

              isAnimating: isAnimating,
              animDuration: animDuration,
              child: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Assets.assetsPngFlagEg, height: 24, width: 24),
                    Text(L10n.tr().arabic, style: TStyle.primarySemi(16)),
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
