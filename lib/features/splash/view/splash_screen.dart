import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/onboarding/onboarding_logo_screen.dart';

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
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) contoller.animateBack(0.0);
    });
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) textController.forward();
    });
  }

  @override
  void initState() {
    contoller = AnimationController(vsync: this, duration: Durations.medium4);
    textController = AnimationController(vsync: this, duration: Durations.short4);
    Future.delayed(Duration(seconds: 2), () => _startAnimate());
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
    return Scaffold(
      backgroundColor: Co.dark,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Co.burble],
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
                          child: Text('HELLO', style: TStyle.whiteBold(60)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VerticalSpacing(20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(_createRoute());
                },
                child: Text('Next', style: TStyle.blackBold(18)),
              ),
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
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: Durations.long4,
      pageBuilder: (context, animation, secondaryAnimation) => const OnboardingStartScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0);
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
