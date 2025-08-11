import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/option_btn.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/video_tutorial_screen.dart';
import 'package:go_router/go_router.dart';

class TutorialBottomSheet extends StatefulWidget {
  const TutorialBottomSheet({super.key});

  @override
  State<TutorialBottomSheet> createState() => _TutorialBottomSheetState();
}

class _TutorialBottomSheetState extends State<TutorialBottomSheet> {
  final isAnimating = ValueNotifier<bool>(false);
  final animDuration = const Duration(milliseconds: 500);

  Future navigateToLoginScreen() async {
    context.pushReplacement(LoginScreen.route);
  }

  Future<void> changeLanguage(String lang) async {
    isAnimating.value = false;
    if (mounted) context.read<AppSettingsCubit>().changeLanguage(lang);
    await Future.delayed(Durations.medium2);
    navigateToLoginScreen();
  }

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
    return Scaffold(
      backgroundColor: Co.bg.withAlpha(125),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: 1.8,
                  child: Hero(
                    tag: Tags.cloud,
                    child: Image.asset(Assets.assetsPngCloudLogo, fit: BoxFit.fill, alignment: Alignment.center, color: Colors.white),
                  ),
                ),
                Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GradientText(text: L10n.tr().selectLanguage, style: TStyle.blackBold(24), gradient: Grad().textGradient),
                    const SizedBox(height: 40, width: double.infinity),
                    PlanAnimatedBtn(
                      onPressed: () => changeLanguage('en'),

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
                      onPressed: () => changeLanguage('ar'),
                      isAnimating: isAnimating,
                      animDuration: animDuration,
                      child: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(Assets.assetsPngFlagEg, height: 24, width: 24),
                            Text("العربية", style: TStyle.primarySemi(16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            DecoratedBox(
              decoration: const BoxDecoration(
                color: Co.bg,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80), topRight: Radius.circular(80)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  child: Row(
                    spacing: 24,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OptionBtn(
                          onPressed: () {
                            navigateToLoginScreen();
                          },
                          text: L10n.tr().skip,
                        ),
                      ),
                      Expanded(
                        child: OptionBtn(
                          onPressed: () {
                            context.pushReplacement(VideoTutorialScreen.route);
                          },
                          text: L10n.tr().learnMore,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
