import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class SlideTimer extends StatefulWidget {
  const SlideTimer({super.key, required this.duration, required this.startTime, this.textStyle});
  final Duration duration;
  final DateTime startTime;
  final TextStyle? textStyle;

  @override
  State<SlideTimer> createState() => _SlideTimerState();
}

class _SlideTimerState extends State<SlideTimer> {
  late final Timer timer;
  late int hours;
  late int minutes;
  late int seconds;
  late final TextStyle style;
  _calculate() {
    final restTime = widget.startTime.difference(DateTime.now());
    hours = restTime.inHours.remainder(24);
    minutes = restTime.inMinutes.remainder(60);
    seconds = restTime.inSeconds.remainder(60);
    if (hours < 0 && minutes < 0 && seconds < 0) {
      hours = 0;
      minutes = 0;
      seconds = 0;
      timer.cancel();
    }
  }

  @override
  void initState() {
    style = widget.textStyle ?? TStyle.blackBold(18);
    _calculate();
    timer = Timer.periodic(widget.duration, (timer) {
      setState(() => _calculate());
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            final inAnimation = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(animation);
            final outAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: child.key == ValueKey(hours) ? inAnimation : outAnimation, child: child),
            );
          },

          child: Text(key: ValueKey(hours), hours.toString().padLeft(2, '0'), style: style),
        ),
        Text(" : ", style: style),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            final inAnimation = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(animation);
            final outAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: child.key == ValueKey(minutes) ? inAnimation : outAnimation, child: child),
            );
          },

          child: Text(key: ValueKey(minutes), minutes.toString().padLeft(2, '0'), style: style),
        ),
        Text(" : ", style: style),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            final inAnimation = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(animation);
            final outAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: child.key == ValueKey(seconds) ? inAnimation : outAnimation, child: child),
            );
          },

          child: Text(key: ValueKey(seconds), seconds.toString().padLeft(2, '0'), style: style),
        ),
      ],
    );
  }
}
