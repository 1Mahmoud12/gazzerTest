import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/slide_timer.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';

class CountDownBanner extends StatefulWidget {
  const CountDownBanner({super.key, required this.banner});
  final BannerEntity banner;
  @override
  State<CountDownBanner> createState() => _CountDownBannerState();
}

class _CountDownBannerState extends State<CountDownBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Timer _timer;
  final animationduration = const Duration(milliseconds: 500);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: animationduration, lowerBound: 0, upperBound: 1);
    // _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
    // _animate();

    _timer = Timer.periodic(const Duration(milliseconds: 3000), (_) {
      if (_controller.isAnimating) return;
      _animate();
    });
    super.initState();
  }

  _animate() {
    _controller.forward().then((_) {
      _controller.animateBack(0, duration: animationduration);
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
    return SizedBox(
      height: 155,
      child: Stack(
        children: [
          SizedBox.expand(
            child: CustomNetworkImage(
              widget.banner.backgroundImage ?? '',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment(widget.banner.offset?.dx ?? -0.95, widget.banner.offset?.dy ?? -1),
            child: RotationTransition(
              alignment: Alignment.topCenter,
              turns: Tween<double>(begin: 0, end: -0.015).animate(_controller),
              child: CustomNetworkImage(widget.banner.foreGroundImage ?? '', fit: BoxFit.cover, height: 120),
            ),
          ),
          Align(
            alignment: const Alignment(0.6, -0.3),
            child: SlideTimer(
              duration: const Duration(seconds: 1),
              startTime: DateTime.now().add(const Duration(hours: 1)),
            ),
          ),
        ],
      ),
    );
  }
}
