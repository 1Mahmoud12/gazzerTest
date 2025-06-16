import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class CatRestShakingImgAddWidget extends StatefulWidget {
  const CatRestShakingImgAddWidget({super.key});

  @override
  State<CatRestShakingImgAddWidget> createState() => _CatRestShakingImgAddWidgetState();
}

class _CatRestShakingImgAddWidgetState extends State<CatRestShakingImgAddWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Timer _timer;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 0.015,
    );
    // _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
    // _animate();

    _timer = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      if (_controller.isAnimating) return;
      _animate();
    });
    super.initState();
  }

  _animate() {
    _controller.forward().then((_) {
      _controller.animateBack(0, duration: const Duration(milliseconds: 300));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Co.buttonGradient.withAlpha(30), Colors.black.withAlpha(0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36 ),
                      child: Badge(
                        backgroundColor: Colors.transparent,
                        label: SvgPicture.asset(Assets.assetsSvgTripleStarts, width: 32, height: 32),
                        alignment: const Alignment(0.65, -1),
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Co.bg, borderRadius: AppConst.defaultBorderRadius),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 6, 24, 6),
                            child: Text("Buy 3\nGet 4 Free", style: TStyle.primaryBold(20)),
                          ),
                        ),
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          ...List.generate(
                            3,
                            (i) => TextSpan(
                              text: "${i == 0 ? "" : "Buy More "}& Save More",
                              style: TStyle.blackBold(14),
                              children: [
                                const WidgetSpan(
                                  child: Icon(Icons.battery_charging_full_rounded, color: Co.secondary, size: 24),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -20,
            bottom: 0,
            child: RotationTransition(
              alignment: Alignment.topRight,
              turns: _controller,
              child: Image.asset(Assets.assetsPngPizza, height: 200),
            ),
          ),
        ],
      ),
    );
  }
}
