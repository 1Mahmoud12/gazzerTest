import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/custom_page_transition_builder.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {TargetPlatform.android: CustomPageTransitionBuilder(), TargetPlatform.iOS: CustomPageTransitionBuilder()},
    ),
    textTheme: TextTheme(titleMedium: TStyle.whiteSemi(14), bodyMedium: TStyle.whiteSemi(13)),
    fontFamily: 'poppins',
    scaffoldBackgroundColor: Co.bg,
    switchTheme: SwitchThemeData(
      thumbColor: const WidgetStateColor.fromMap({WidgetState.selected: Co.white, WidgetState.any: Co.tertiary}),
      trackColor: const WidgetStateColor.fromMap({WidgetState.selected: Co.second2, WidgetState.any: Co.lightGrey}),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      trackOutlineColor: WidgetStatePropertyAll(Colors.grey.shade400),
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
    buttonTheme: ButtonThemeData(height: 0, minWidth: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultInnerRadius))),
  );
}
