import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

enum FFamily { inter, playfair, poppins, roboto, Alexandria }

abstract class TStyle {
  static const regular = FontWeight.w400;

  static const semi = FontWeight.w600;

  static const bold = FontWeight.w700;
  static const medium = FontWeight.w500;
  static const bolder = FontWeight.w900;

  static FFamily _getFontFamily({FFamily? font, BuildContext? context}) {
    if (font != null) return font;
    // Check language from context or fallback to main context
    final ctx = context ?? AppNavigator.mainKey.currentContext;
    if (ctx != null && L10n.isAr(ctx)) {
      return FFamily.Alexandria;
    }
    return FFamily.roboto;
  }

  static double _getFontSize({required double fontSize, BuildContext? context}) {
    // Check language from context or fallback to main context
    final ctx = context ?? AppNavigator.mainKey.currentContext;
    if (ctx != null && L10n.isAr(ctx)) {
      // Reduce font size by 2 for Arabic
      return fontSize - 2;
    }
    return fontSize;
  }

  static TextStyle robotBlackHead({double fontSize = 32, FFamily? font, BuildContext? context}) => TextStyle(
    fontFamily: _getFontFamily(font: font, context: context).name,
    fontSize: _getFontSize(fontSize: fontSize, context: context).sp,
    fontWeight: bold,
    color: Co.dark,
  );

  static TextStyle robotBlackTitle({double fontSize = 24, FFamily? font, BuildContext? context}) => TextStyle(
    fontFamily: _getFontFamily(font: font, context: context).name,
    fontSize: _getFontSize(fontSize: fontSize, context: context).sp,
    fontWeight: medium,
    color: Co.dark,
  );

  static TextStyle robotBlackSubTitle({double fontSize = 20, FFamily? font, BuildContext? context}) => TextStyle(
    fontFamily: _getFontFamily(font: font, context: context).name,
    fontSize: _getFontSize(fontSize: fontSize, context: context).sp,
    fontWeight: medium,
    color: Co.dark,
  );

  static TextStyle robotBlackMedium({double fontSize = 16, FFamily? font, BuildContext? context}) => TextStyle(
    fontFamily: _getFontFamily(font: font, context: context).name,
    fontSize: _getFontSize(fontSize: fontSize, context: context).sp,
    fontWeight: medium,
    color: Co.dark,
  );

  static TextStyle robotBlackRegular({double fontSize = 16, FFamily? font, BuildContext? context}) => TextStyle(
    fontFamily: _getFontFamily(font: font, context: context).name,
    fontSize: _getFontSize(fontSize: fontSize, context: context).sp,
    fontWeight: regular,
    color: Co.dark,
  );

  static TextStyle robotBlackSmall({double fontSize = 14, FFamily? font, BuildContext? context}) => TextStyle(
    fontFamily: _getFontFamily(font: font, context: context).name,
    fontSize: _getFontSize(fontSize: fontSize, context: context).sp,
    fontWeight: regular,
    color: Co.dark,
  );

  static TextStyle robotBlackThin({double fontSize = 12, FFamily? font, BuildContext? context}) => TextStyle(
    fontFamily: _getFontFamily(font: font, context: context).name,
    fontSize: _getFontSize(fontSize: fontSize, context: context).sp,
    fontWeight: regular,
    color: Co.dark,
  );
}
