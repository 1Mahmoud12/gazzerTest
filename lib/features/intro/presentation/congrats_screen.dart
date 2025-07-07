import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart'
    show GradientText, HorizontalSpacing, OptionBtn, VerticalSpacing;

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key, required this.navigateTo});
  final Widget navigateTo;
  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  late final ConfettiController controller;
  final isAnimating = ValueNotifier(false);
  @override
  void initState() {
    controller = ConfettiController(duration: const Duration(seconds: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.play();
      isAnimating.value = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    isAnimating.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundWidget(
      image: Assets.assetsPngShape6,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.1),

              child: ValueListenableBuilder(
                valueListenable: isAnimating,
                builder: (context, value, child) => AnimatedOpacity(
                  duration: Durations.medium4,
                  opacity: value ? 1 : 0,
                  child: AnimatedScale(scale: value ? 1 : 0, duration: Durations.medium4, child: child),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    const HorizontalSpacing(double.infinity),
                    GradientText(
                      text: "${L10n.tr().congratulations}!",
                      style: TStyle.blackBold(32),
                      gradient: Grad.radialGradient,
                    ),
                    GradientText(text: L10n.tr().youMadeIt, style: TStyle.mainwBold(16), gradient: Grad.radialGradient),
                    const VerticalSpacing(12),
                    OptionBtn(
                      onPressed: () {
                        context.myPushAndRemoveUntil(widget.navigateTo);
                      },
                      width: 209,
                      child: GradientText(text: L10n.tr().start, style: TStyle.blackSemi(13)),
                    ),
                    const VerticalSpacing(24),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.1),
              child: ConfettiWidget(
                confettiController: controller,
                blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
                shouldLoop: true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.yellow,
                  Colors.purple,
                ], // manually specify the colors to be used
                numberOfParticles: 12,
                gravity: 0.08,
                maxBlastForce: 10,
                minBlastForce: 2,
                minimumSize: const Size(15, 15),
                maximumSize: const Size(30, 30),
                emissionFrequency: 0.01,
                // createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
