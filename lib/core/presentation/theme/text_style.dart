import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

abstract class TStyle {
  static const regular = FontWeight.w200;

  static const semi = FontWeight.w500;

  static const bold = FontWeight.w700;
  static const bolder = FontWeight.w900;

  //
  static TextStyle primaryRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.purple);
  static TextStyle primarySemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.purple);
  static TextStyle primaryBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.purple);
  static TextStyle secondaryRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.secondary);
  static TextStyle secondarySemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.secondary);
  static TextStyle secondaryBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.secondary);
  static TextStyle tertiaryRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.tertiary);
  static TextStyle tertiarySemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.tertiary);
  static TextStyle tertiaryBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.tertiary);
  static TextStyle burbleRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.lightPurple);
  static TextStyle burbleSemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.lightPurple);
  static TextStyle burbleBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.lightPurple);
  static TextStyle mainwRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.mainText);
  static TextStyle mainwSemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.mainText);
  static TextStyle mainwBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.mainText);

  static TextStyle errorRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.red);
  static TextStyle errorSemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.red);
  static TextStyle errorBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.red);

  static TextStyle greyRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.greyText);
  static TextStyle greySemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.greyText);
  static TextStyle greyBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.greyText);
  static TextStyle whiteRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.white);
  static TextStyle whiteSemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.white);
  static TextStyle whiteBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.white);
  static TextStyle blackRegular(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: regular, color: Co.dark);
  static TextStyle blackSemi(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: semi, color: Co.dark);
  static TextStyle blackBold(double fontSize, {bool isInter = false}) =>
      TextStyle(fontFamily: isInter ? 'Inter' : null, fontSize: fontSize, fontWeight: bold, color: Co.dark);
}
