import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 800);

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Use a fade transition for all page transitions
    return FadeTransition(opacity: animation, child: child);
  }
}

// class AppTransitions {
//   const AppTransitions._();
//   static const AppTransitions _instance = AppTransitions._();
//   factory AppTransitions() {
//     return _instance;
//   }

//   Route slideTransition(Widget nextPage, {Offset? start, Duration? duration, Curve? curve}) {
//     return PageRouteBuilder(
//       transitionDuration: duration ?? Durations.long4,
//       pageBuilder: (context, animation, secondaryAnimation) => nextPage,
//       reverseTransitionDuration: duration ?? Durations.long4,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         var tween = Tween(
//           begin: start ?? const Offset(1.0, 0),
//           end: Offset.zero,
//         ).chain(CurveTween(curve: curve ?? Curves.fastEaseInToSlowEaseOut));
//         final offsetAnimation = animation.drive(tween);
//         return SlideTransition(position: offsetAnimation, child: child);
//       },
//     );
//   }

//   Route slideFadeTransition(Widget nextPage, {Offset? start, Duration? duration, Curve? curve}) {
//     return PageRouteBuilder(
//       transitionDuration: duration ?? Durations.long4,
//       pageBuilder: (context, animation, secondaryAnimation) => nextPage,
//       reverseTransitionDuration: duration ?? Durations.long4,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         var tween = Tween(
//           begin: start ?? const Offset(1.0, 0),
//           end: Offset.zero,
//         ).chain(CurveTween(curve: curve ?? Curves.fastEaseInToSlowEaseOut));
//         final offsetAnimation = animation.drive(tween);
//         return FadeTransition(
//           opacity: animation,
//           child: SlideTransition(position: offsetAnimation, child: child),
//         );
//       },
//     );
//   }
// }
