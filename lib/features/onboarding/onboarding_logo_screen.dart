import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/main_btn.dart';
import 'package:gazzer/features/onboarding/onboarding_first_screen.dart';

class OnboardingStartScreen extends StatelessWidget {
  const OnboardingStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.assetsPngSplash), fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),

                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.assetsPngCloud), fit: BoxFit.fill, alignment: Alignment.center),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Hero(
                        tag: 'cloud',
                        child: Image.asset(Assets.assetsPngGazzer, width: 200, fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 102,
              right: -15,
              child: MainBtn(
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                text: "Start",
                textStyle: TStyle.whiteBold(16),
                padding: EdgeInsets.symmetric(horizontal: 15),
                icon: Icons.arrow_forward_ios_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: Durations.long4,
      pageBuilder: (context, animation, secondaryAnimation) => const OnboardingFirstScreen(),
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
