import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

extension NavigationExtension on BuildContext {
  Future<dynamic> navigateToPage(
    Widget widget, {
    PageTransitionType? pageTransitionType,
    int? animation,
  }) async {
    return Navigator.of(this).push(
      PageTransition(
        child: widget,
        type: pageTransitionType ?? PageTransitionType.fade,
        duration: Duration(milliseconds: animation ?? 300),
      ),
    );
  }

  Future<dynamic> navigateToPageWithReplacement(
    Widget page, {
    int? animation,
  }) async {
    return Navigator.of(this).pushReplacement(
      PageTransition(
        child: page,
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: animation ?? 300),
      ),
    );
  }

  Future<dynamic> navigateToPageWithClearStack(
    Widget page, {
    int? animation,
  }) async {
    return Navigator.of(this).pushAndRemoveUntil(
      PageTransition(
        child: page,
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: animation ?? 300),
      ),
      (route) => false,
    );
  }
}
