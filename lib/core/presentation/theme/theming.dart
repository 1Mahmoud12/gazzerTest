import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/constants.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Co.bg,
    appBarTheme: AppBarTheme(color: Colors.transparent, centerTitle: true),
    buttonTheme: ButtonThemeData(height: 0, minWidth: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultRadius))),
  );
}
