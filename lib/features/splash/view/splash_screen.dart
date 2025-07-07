import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/routing/custom_page_transition_builder.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/intro_video_tutorial_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController contoller;
  late final AnimationController textController;

  _startAnimate() async {
    if (mounted) contoller.forward();
    await Future.delayed(const Duration(seconds: 1), () {
      if (mounted) contoller.animateBack(0.0);
    });
    await Future.delayed(const Duration(seconds: 1), () {
      if (mounted) textController.forward();
    });
    await Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          AppTransitions().slideTransition(
            const IntroVideoTutorialScreen(videoLink: ''),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    contoller = AnimationController(vsync: this, duration: Durations.medium4);
    textController = AnimationController(vsync: this, duration: Durations.short4);
    Future.delayed(const Duration(seconds: 2), () => _startAnimate());
    super.initState();
  }

  @override
  void dispose() {
    contoller.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Co.dark,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Co.purple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 0.4, end: 1.0).animate(contoller),
                  child: RotationTransition(
                    turns: Tween<double>(begin: 0.0, end: 0.37).animate(contoller),
                    child: Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.assetsSvgSplashIcon, height: 90, width: 90),
                        SizeTransition(
                          axis: Axis.horizontal,
                          axisAlignment: 1,
                          sizeFactor: textController,
                          child: FadeTransition(
                            opacity: textController,
                            child: Text('HELLO', style: TStyle.whiteBold(92).copyWith(color: Co.bg)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpacing(20),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pushReplacement(_createRoute());
                //   },
                //   child: Text(L10n.tr().next, style: TStyle.blackBold(18)),
                // ),
                // MaterialButton(
                //   onPressed: () {
                //     if (textController.isCompleted) {
                //       textController.reset();
                //     }
                //     Future.delayed(Duration(seconds: 1), () => _startAnimate());
                //   },
                //   child: Text('Repeat', style: TStyle.whiteBold(32)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
