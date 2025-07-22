import 'dart:async';

import 'package:flutter/material.dart';

class ShakingBanner extends StatefulWidget {
  const ShakingBanner({super.key, required this.foreGround, required this.backGround});
  final String foreGround;
  final String backGround;
  @override
  State<ShakingBanner> createState() => _ShakingBannerState();
}

class _ShakingBannerState extends State<ShakingBanner> with SingleTickerProviderStateMixin {
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
    return AspectRatio(
      aspectRatio: 1.83,
      child: ColoredBox(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 2.15,
                child: Image.asset(
                  widget.backGround,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.info_outline, size: 32),
                ),
              ),
              Positioned(
                right: -20,
                bottom: 0,
                child: RotationTransition(
                  alignment: Alignment.topRight,
                  turns: _controller,
                  child: Image.asset(widget.foreGround, height: 200),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
