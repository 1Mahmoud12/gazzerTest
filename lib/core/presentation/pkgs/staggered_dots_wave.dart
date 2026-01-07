import 'package:flutter/material.dart';

class StaggeredDotsWave extends StatefulWidget {
  final double size;
  final int dotsNumber;
  final List<Color> colors;
  const StaggeredDotsWave({super.key, required this.size, required this.dotsNumber, required this.colors})
    : assert(dotsNumber == colors.length, 'dotsNumber must match the length of colors list');

  @override
  State<StaggeredDotsWave> createState() => _StaggeredDotsWaveState();
}

class _StaggeredDotsWaveState extends State<StaggeredDotsWave> with SingleTickerProviderStateMixin {
  late AnimationController _offsetController;
  late final double oddDotHeight;
  late final double evenDotHeight;

  final baseIntervals = [const Interval(0.0, 0.1), const Interval(0.18, 0.28), const Interval(0.28, 0.38), const Interval(0.47, 0.57)];

  Interval _getInterval(int index, int intervalIndex) {
    final interval = baseIntervals[intervalIndex];
    return Interval(interval.begin + (index * 0.09), interval.end + (index * 0.09));
  }

  @override
  void initState() {
    super.initState();
    oddDotHeight = widget.size * 0.4;
    evenDotHeight = widget.size * 0.7;
    _offsetController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat();
  }

  @override
  void dispose() {
    _offsetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // color: Colors.black,
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _offsetController,
        builder: (_, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ...List.generate(widget.dotsNumber, (index) {
              return DotContainer(
                controller: _offsetController,
                heightInterval: _getInterval(index, 0),
                offsetInterval: _getInterval(index, 1),
                reverseHeightInterval: _getInterval(index, 2),
                reverseOffsetInterval: _getInterval(index, 3),
                color: widget.colors[index],
                size: widget.size,
                maxHeight: oddDotHeight,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class DotContainer extends StatelessWidget {
  final Interval offsetInterval;
  final double size;
  final Color color;

  final Interval reverseOffsetInterval;
  final Interval heightInterval;
  final Interval reverseHeightInterval;
  final double maxHeight;
  final AnimationController controller;

  const DotContainer({
    super.key,
    required this.offsetInterval,
    required this.size,
    required this.color,
    required this.reverseOffsetInterval,
    required this.heightInterval,
    required this.reverseHeightInterval,
    required this.maxHeight,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // final Interval interval = widget.offsetInterval;
    // final Interval reverseInterval = widget.reverseOffsetInterval;
    // final Interval heightInterval = widget.heightInterval;
    // final double size = widget.size;
    // final Interval reverseHeightInterval = widget.reverseHeightInterval;
    // final double maxHeight = widget.maxHeight;
    final double maxDy = -(size * 0.20);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: controller.value <= offsetInterval.end ? 1 : 0,
              // opacity: 1,
              child: Transform.translate(
                offset: controller.eval(
                  Tween<Offset>(begin: Offset.zero, end: Offset(0, maxDy)),
                  curve: offsetInterval,
                ),
                child: Container(
                  width: size * 0.13,
                  height: size * 0.13,
                  // height: controller.eval(
                  //   Tween<double>(begin: size * 0.13, end: maxHeight),
                  //   curve: heightInterval,
                  // ),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size)),
                ),
              ),
            ),
            Opacity(
              opacity: controller.value >= offsetInterval.end ? 1 : 0,
              child: Transform.translate(
                offset: controller.eval(
                  Tween<Offset>(begin: Offset(0, maxDy), end: Offset.zero),
                  curve: reverseOffsetInterval,
                ),
                child: Container(
                  width: size * 0.13,
                  height: size * 0.13,

                  // height: controller.eval(
                  //   Tween<double>(begin: maxHeight, end: size * 0.13),
                  //   curve: reverseHeightInterval,
                  // ),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

extension LoadingAnimationControllerX on AnimationController {
  T eval<T>(Tween<T> tween, {Curve curve = Curves.linear}) => tween.transform(curve.transform(value));

  double evalDouble({double from = 0, double to = 1, double begin = 0, double end = 1, Curve curve = Curves.linear}) {
    return eval(
      Tween<double>(begin: from, end: to),
      curve: Interval(begin, end, curve: curve),
    );
  }
}
