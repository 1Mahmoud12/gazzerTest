import 'package:flutter/material.dart';

class AppTransitions {
  const AppTransitions._();
  static const AppTransitions _instance = AppTransitions._();
  factory AppTransitions() {
    return _instance;
  }

  Route slideTransition(Widget nextPage, {Offset? start, Duration? duration, Curve? curve}) {
    return PageRouteBuilder(
      transitionDuration: duration ?? Durations.long4,
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      reverseTransitionDuration: duration ?? Durations.long4,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(
          begin: start ?? const Offset(1.0, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: curve ?? Curves.fastEaseInToSlowEaseOut));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
