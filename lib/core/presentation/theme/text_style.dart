import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

enum FFamily { inter, playfair, poppins }

abstract class TStyle {
  static const regular = FontWeight.w200;

  static const semi = FontWeight.w500;

  static const bold = FontWeight.w700;
  static const bolder = FontWeight.w900;

  //
  static TextStyle primaryRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.purple);
  static TextStyle primarySemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.purple);
  static TextStyle primaryBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.purple);
  static TextStyle secondaryRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.secondary);
  static TextStyle secondarySemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.secondary);
  static TextStyle secondaryBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.secondary);
  static TextStyle tertiaryRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.tertiary);
  static TextStyle tertiarySemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.tertiary);
  static TextStyle tertiaryBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.tertiary);
  static TextStyle burbleRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.lightPurple);
  static TextStyle burbleSemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.lightPurple);
  static TextStyle burbleBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.lightPurple);
  static TextStyle mainwRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.mainText);
  static TextStyle mainwSemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.mainText);
  static TextStyle mainwBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.mainText);

  static TextStyle errorRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.red);
  static TextStyle errorSemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.red);
  static TextStyle errorBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.red);

  static TextStyle greyRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.greyText);
  static TextStyle greySemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.greyText);
  static TextStyle greyBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.greyText);
  static TextStyle whiteRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.white);
  static TextStyle whiteSemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.white);
  static TextStyle whiteBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.white);
  static TextStyle blackRegular(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: regular, color: Co.dark);
  static TextStyle blackSemi(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: semi, color: Co.dark);
  static TextStyle blackBold(double fontSize, {FFamily font = FFamily.poppins}) =>
      TextStyle(fontFamily: font.name, fontSize: fontSize, fontWeight: bold, color: Co.dark);
}
