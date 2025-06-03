import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/option_btn.dart';
import 'package:gazzer/core/presentation/widgets/shaped_bg_widget.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/main_layout/views/main_layout.dart';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key});

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  late final ConfettiController controller;

  @override
  void initState() {
    controller = ConfettiController(duration: const Duration(seconds: 1));
    controller.play();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShapedBgWidget(
      shape: Assets.assetsPngShape6,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                spacing: 12,
                children: [
                  const HorizontalSpacing(double.infinity),
                  GradientText(
                    text: L10n.tr().congratulations,
                    style: TStyle.blackBold(24),
                    gradient: Grad.radialGradient,
                  ),
                  Text(L10n.tr().youMadeIt, style: TStyle.mainwBold(16)),
                  OptionBtn(onPressed: () {
                    context.myPushAndRemoveUntil(const MainLayout());
                  }, text: L10n.tr().start, width: 250),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
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
