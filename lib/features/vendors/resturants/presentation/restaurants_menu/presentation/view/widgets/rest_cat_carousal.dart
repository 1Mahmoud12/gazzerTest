// part of '../restaurants_menu_screen.dart';

import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RestCatCarousal extends StatefulWidget {
  const RestCatCarousal({super.key});

  @override
  State<RestCatCarousal> createState() => _RestCatCarousalState();
}

class _RestCatCarousalState extends State<RestCatCarousal> {
  final PageController controller = PageController(viewportFraction: 1);
  final adds = [Assets.assetsPngRestAdd1, Assets.assetsPngRestAdd2, Assets.assetsPngRestAdd3];
  late final Timer timer;
  int index = 0;

  _animate() {
    if (index < (adds.length - 1)) {
      controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      setState(() => index++);
    } else {
      controller.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      setState(() => index = 0);
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _animate();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageTransitionSwitcher(
            duration: Durations.long4,
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                FadeTransition(opacity: primaryAnimation, child: child),
            child: Image.asset(
              key: ValueKey(index),
              adds[index],
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              itemCount: adds.length,
              scrollDirection: Axis.horizontal,
              padEnds: true,
              onPageChanged: (value) => setState(() => index = value),
              itemBuilder: (context, index) => const ColoredBox(color: Colors.transparent),
            ),
          ),

          Align(
            alignment: const Alignment(-0.9, 0.88),
            child: MainBtn(
              text: L10n.tr().orderNow,
              height: 32,
              width: 110,
              bgColor: Co.secondary,
              textStyle: TStyle.primaryBold(14),
              onPressed: () {},
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: controller, // PageController
              count: adds.length,
              effect: CustomizableEffect(
                dotDecoration: DotDecoration(
                  height: 7,
                  width: 7,
                  color: Co.darkPurple,
                  borderRadius: BorderRadius.circular(100),
                ),
                activeDotDecoration: DotDecoration(
                  height: 7,
                  width: 27,
                  color: Co.darkPurple,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
