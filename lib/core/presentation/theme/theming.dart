import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/custom_page_transition_builder.dart';

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Co.bg,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    buttonTheme: ButtonThemeData(
      height: 0,
      minWidth: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultInnerRadius)),
    ),
  );
}
