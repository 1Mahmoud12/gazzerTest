import 'package:flutter/material.dart';

class AppTransitions {
  const AppTransitions._();
  static const AppTransitions _instance = AppTransitions._();
  factory AppTransitions() {
    return _instance;
  }

  Route slideTransition(Widget nextPage) {
    return PageRouteBuilder(
      transitionDuration: Durations.long4,
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0);
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
