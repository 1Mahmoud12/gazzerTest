import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';

class AnimatedDiscountPercentageWidget extends StatefulWidget {
  const AnimatedDiscountPercentageWidget({super.key});

  @override
  State<AnimatedDiscountPercentageWidget> createState() => _AnimatedDiscountPercentageWidgetState();
}

class _AnimatedDiscountPercentageWidgetState extends State<AnimatedDiscountPercentageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: -0.05,
      upperBound: 0,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Badge(
          backgroundColor: Colors.transparent,
          alignment: const Alignment(0,0),
          padding: const EdgeInsets.all(8),
          label: RotationTransition(
            turns: _controller,
            child: SvgPicture.asset(Assets.assetsSvgPercentage, height: 71, fit: BoxFit.contain),
          ),
          child: SvgPicture.asset(Assets.assetsSvgPercentageBg, width: 150, fit: BoxFit.contain),
        ),
      ],
    );
  }
}
