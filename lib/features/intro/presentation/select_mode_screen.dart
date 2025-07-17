import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/auth/register/presentation/view/register_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/plan_animated_btn.dart';

class SelectModeScreen extends StatefulWidget {
  const SelectModeScreen({super.key});

  @override
  State<SelectModeScreen> createState() => _SelectModeScreenState();
}

class _SelectModeScreenState extends State<SelectModeScreen> {
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
      image: Assets.assetsPngMoodShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ClassicAppBar(),
        body: Column(
          spacing: 12,
          children: [
            Hero(tag: Tags.character, child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
            GradientText(text: L10n.tr().howToLogin, style: TStyle.blackBold(24), gradient: Grad().textGradient),
            const SizedBox(height: 40, width: double.infinity),
            Hero(
              tag: Tags.btn,
              child: PlanAnimatedBtn(
                onPressed: () {
                  isAnimating.value = false;
                  context.myPushAndRemoveUntil(const LoadingScreen(navigateTo: MainLayout()));
                },
                text: L10n.tr().guestMode,
                isAnimating: isAnimating,
                animDuration: animDuration,
              ),
            ),
            const SizedBox.shrink(),

            PlanAnimatedBtn(
              onPressed: () {
                isAnimating.value = false;
                context.myPush(const LoginScreen()).then((v) => isAnimating.value = true);
              },
              text: L10n.tr().login,
              isAnimating: isAnimating,
              animDuration: animDuration,
            ),
            const SizedBox.shrink(),
            PlanAnimatedBtn(
              onPressed: () {
                isAnimating.value = false;
                context.myPush(BlocProvider(create: (context) => di<RegisterCubit>(), child: const RegisterScreen())).then((v) {
                  isAnimating.value = true;
                });
              },
              text: L10n.tr().signUp,
              isAnimating: isAnimating,
              animDuration: animDuration,
            ),
          ],
        ),
      ),
    );
  }
}
