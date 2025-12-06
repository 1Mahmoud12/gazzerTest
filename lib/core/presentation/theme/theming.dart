import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/custom_page_transition_builder.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
    textTheme: TextTheme(titleMedium: TStyle.whiteSemi(14), bodyMedium: TStyle.whiteSemi(13)),
    fontFamily: 'poppins',
    scaffoldBackgroundColor: Co.bg,
    switchTheme: const SwitchThemeData(
      thumbColor: WidgetStateColor.fromMap({WidgetState.selected: Co.secondary, WidgetState.any: Co.purple}),
      trackColor: WidgetStateColor.fromMap({
        WidgetState.selected: Color(0x55FF9900),
        WidgetState.any: Color(0x5552229E),
      }),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    ),

    ///
    ///
    ///
    appBarTheme: const AppBarTheme(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.black,
      //   statusBarBrightness: Brightness.light,
      //   systemStatusBarContrastEnforced: true,
      // ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    buttonTheme: ButtonThemeData(
      height: 0,
      minWidth: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultInnerRadius)),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: Color(0xffF0F0F0),
    ),
  );
}
