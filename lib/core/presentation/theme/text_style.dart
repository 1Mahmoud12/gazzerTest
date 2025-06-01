import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

abstract class TStyle {
  static const regular = FontWeight.w200;

  static const semi = FontWeight.w500;

  static const bold = FontWeight.w700;
  static const bolder = FontWeight.w900;

  //
  static TextStyle mainwRegular(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: regular,
    color: Co.mainText,
  );
  static TextStyle mainwSemi(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: semi,
    color: Co.mainText,
  );
  static TextStyle mainwBold(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: bold,
    color: Co.mainText,
  );

  static TextStyle errorRegular(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: regular,
    color: Co.red,
  );
  static TextStyle errorSemi(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: semi,
    color: Co.red,
  );
  static TextStyle errorBold(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: bold,
    color: Co.red,
  );

  static TextStyle greyRegular(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: regular,
    color: Co.greyText,
  );
  static TextStyle greySemi(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: semi,
    color: Co.greyText,
  );
  static TextStyle greyBold(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: bold,
    color: Co.greyText,
  );
  static TextStyle whiteRegular(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: regular,
    color: Co.white,
  );
  static TextStyle whiteSemi(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: semi,
    color: Co.white,
  );
  static TextStyle whiteBold(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: bold,
    color: Co.white,
  );
  static TextStyle blackRegular(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: regular,
    color: Co.dark,
  );
  static TextStyle blackSemi(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: semi,
    color: Co.dark,
  );
  static TextStyle blackBold(double fontSize, {bool isTitle = false}) => TextStyle(
    // fontFamily: isTitle ? 'Lemon' : null,
    fontSize: fontSize,
    fontWeight: bold,
    color: Co.dark,
  );
}
