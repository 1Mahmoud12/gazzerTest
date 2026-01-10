import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularCarousalWidget extends StatefulWidget {
  const CircularCarousalWidget({
    super.key,
    required this.itemsCount,
    required this.itemBuilder,
    required this.maxItemWidth,
  });
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemsCount;
  final double maxItemWidth;
  @override
  State<CircularCarousalWidget> createState() => _CircularCarousalWidgetState();
}

class _CircularCarousalWidgetState extends State<CircularCarousalWidget> {
  late PageController _controller;
  late double maxAvailableWidth;

  double _calculatePosition(int index) {
    if (_controller.position.haveDimensions) {
      final value = _controller.page! - index;
      final double position = (-1 + (0.4 * math.pow(value.abs(), 1.8))).clamp(
        -1,
        1.0,
      );
      return position;
    }
    return 0.0;
  }

  double _calculateAngel(int index) {
    if (_controller.position.haveDimensions) {
      final value = _controller.page! - index;
      final angle = -math.pi * (0.5 / 3) * value;
      return angle;
    }
    return 0.0;
  }

  void _updateController() {
    _controller = PageController(
      viewportFraction: widget.maxItemWidth / maxAvailableWidth,
      initialPage: widget.itemsCount ~/ 2,
    );
    // print('maxAvailableWidth: $maxAvailableWidth');
    // print('viewportFraction: ${widget.maxItemWidth / maxAvailableWidth}');
    // print('initialPage: ${widget.itemsCount ~/ 2}');
    // print("_controller: ${_controller.viewportFraction}");
  }

  @override
  void initState() {
    _controller = PageController(
      viewportFraction: 0.27,
      initialPage: widget.itemsCount ~/ 2,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateController();
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircularCarousalWidget oldWidget) {
    if (oldWidget.maxItemWidth != widget.maxItemWidth) {
      _updateController();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        maxAvailableWidth = constraints.maxWidth;
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: PageView.builder(
            allowImplicitScrolling: true,
            controller: _controller,
            itemCount: widget.itemsCount,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ColoredBox(
                    color: Colors.transparent,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: Alignment(0, _calculatePosition(index)),
                          child: Transform.rotate(
                            angle: _calculateAngel(index),
                            child: widget.itemBuilder(context, index),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
