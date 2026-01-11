import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';

extension BuildContextExtension on BuildContext {
  void unFocusKeyboard() => FocusScope.of(this).unfocus();

  dynamic get getArguments => ModalRoute.of(this)?.settings.arguments;

  TextTheme get appTextTheme => Theme.of(this).textTheme;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  double get screenWidth => MediaQuery.sizeOf(this).width;

  Size get screenSize => MediaQuery.of(this).size;

  double get minScreenSize => min(MediaQuery.of(this).size.height, MediaQuery.of(this).size.width);

  double get maxScreenSize => max(MediaQuery.of(this).size.height, MediaQuery.of(this).size.width);

  /// Theme
  ThemeData get theme => Theme.of(this);

  /// TextTheme
  TextTheme get textTheme => theme.textTheme;

  TextStyle get style32700 => textTheme.displayLarge!;
  TextStyle get style24500 => textTheme.titleLarge!;
  TextStyle get style20500 => textTheme.titleMedium!;
  TextStyle get style16500 => textTheme.titleSmall!;
  TextStyle get style16400 => textTheme.labelLarge!;
  TextStyle get style14400 => textTheme.labelMedium!;
  TextStyle get style12400 => textTheme.labelSmall!;
}

extension PaddingList on List<Widget> {
  List<Widget> paddingDirectional({double? top, double? bottom, double? start, double? end}) {
    return map(
      (e) => Padding(
        padding: EdgeInsetsDirectional.only(top: top ?? 0, bottom: bottom ?? 0, start: start ?? 0, end: end ?? 0),
        child: e,
      ),
    ).toList();
  }
}

extension ColorOpacityX on Color {
  Color withOpacityNew(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0.0 and 1.0');
    return withAlpha((opacity * 255).toInt());
  }
}

extension ArabicNumbers on String {
  /// Converts English digits (0-9) to Arabic-Indic digits (٠-٩)
  String toArabicNumbers() {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String result = this;
    if (L10n.isAr(AppNavigator.mainKey.currentContext!)) {
      for (int i = 0; i < english.length; i++) {
        result = result.replaceAll(english[i], arabic[i]);
      }
    }
    return result;
  }
}

extension ArabicNumbersInt on int {
  /// Converts integer to String with Arabic-Indic digits if needed
  String toArabicString({required bool isArabic}) {
    return isArabic ? toString().toArabicNumbers() : toString();
  }
}

extension ArabicNumbersDouble on double {
  /// Converts double to String with Arabic-Indic digits if needed
  String toArabicString({required bool isArabic}) {
    return isArabic ? toString().toArabicNumbers() : toString();
  }
}
