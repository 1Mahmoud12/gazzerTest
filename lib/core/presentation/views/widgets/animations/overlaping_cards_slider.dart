import 'dart:async';

import 'package:flutter/material.dart';

class OverlapingCardsSlider extends StatefulWidget {
  const OverlapingCardsSlider({
    super.key,
    required this.builder,
    required this.itemCount,
    this.scrollDirection = Axis.horizontal,
  });
  final Widget Function(BuildContext context, int index) builder;
  final int itemCount;
  final Axis scrollDirection;
  @override
  State<OverlapingCardsSlider> createState() => _OverlapingCardsSliderState();
}

class _OverlapingCardsSliderState extends State<OverlapingCardsSlider> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int current = 0;
  int next = 1;
  late final Timer timer;
  late final Offset currentEndOffset;
  late final Offset nextStartOffset;

  int increment(int i) {
    i++;
    if (i >= widget.itemCount) i = 0;
    return i;
  }

  _animate() {
    if (_controller.isCompleted) {
      setState(() {
        current = next;
        next = increment(current);
        _controller.reset();
      });
    }
    _controller.forward().then((_) {});
  }

  @override
  void initState() {
    if (widget.scrollDirection == Axis.horizontal) {
      currentEndOffset = const Offset(-1, 0);
      nextStartOffset = const Offset(0.1, 0);
    } else {
      currentEndOffset = const Offset(0, -1);
      nextStartOffset = const Offset(0, 0.1);
    }
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_controller.isAnimating) return;
      _animate();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: Tween<Offset>(
            begin: nextStartOffset,
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
          child: widget.builder(context, next),
        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0),
            end: currentEndOffset,
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
          child: widget.builder(context, current),
        ),
      ],
    );
  }
}
