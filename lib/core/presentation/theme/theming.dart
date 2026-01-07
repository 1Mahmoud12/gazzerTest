import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/custom_page_transition_builder.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';

import '../views/widgets/form_related_widgets.dart/main_text_field.dart';

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {TargetPlatform.android: CustomPageTransitionBuilder(), TargetPlatform.iOS: CustomPageTransitionBuilder()},
    ),
    primaryColor: Co.purple,
    textTheme: TextTheme(
      displayLarge: TStyle.robotBlackHead(),
      titleLarge: TStyle.robotBlackTitle(),
      titleMedium: TStyle.robotBlackSubTitle(),
      labelLarge: TStyle.robotBlackRegular(),
      labelMedium: TStyle.robotBlackRegular14(),
      labelSmall: TStyle.robotBlackSmall(),
      titleSmall: TStyle.robotBlackThin(),
    ),
    scaffoldBackgroundColor: Co.bg,
    switchTheme: const SwitchThemeData(
      thumbColor: WidgetStateColor.fromMap({WidgetState.selected: Co.secondary, WidgetState.any: Co.purple}),
      trackColor: WidgetStateColor.fromMap({WidgetState.selected: Color(0x55FF9900), WidgetState.any: Color(0x5552229E)}),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    ),

    ///
    ///
    ///
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Co.bg,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    buttonTheme: ButtonThemeData(
      height: 0,
      minWidth: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultInnerRadius)),
    ),
    dialogTheme: const DialogThemeData(backgroundColor: Color(0xffF0F0F0)),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Co.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
  );
  static final darkTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {TargetPlatform.android: CustomPageTransitionBuilder(), TargetPlatform.iOS: CustomPageTransitionBuilder()},
    ),
    textTheme: TextTheme(
      displayLarge: TStyle.robotBlackHead().copyWith(color: Co.white),
      titleLarge: TStyle.robotBlackTitle().copyWith(color: Co.white),
      titleMedium: TStyle.robotBlackSubTitle().copyWith(color: Co.white),
      labelLarge: TStyle.robotBlackRegular().copyWith(color: Co.white),
      labelMedium: TStyle.robotBlackRegular14().copyWith(color: Co.white),
      labelSmall: TStyle.robotBlackSmall().copyWith(color: Co.white),
      titleSmall: TStyle.robotBlackThin().copyWith(color: Co.white),
    ),
    primaryColor: Co.white,
    scaffoldBackgroundColor: Co.darkBg,
    switchTheme: const SwitchThemeData(
      thumbColor: WidgetStateColor.fromMap({WidgetState.selected: Co.secondary, WidgetState.any: Co.purple}),
      trackColor: WidgetStateColor.fromMap({WidgetState.selected: Color(0x55FF9900), WidgetState.any: Color(0x5552229E)}),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    ),

    ///
    ///
    ///
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Co.bg,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    buttonTheme: ButtonThemeData(
      height: 0,
      minWidth: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultInnerRadius)),
    ),
    dialogTheme: const DialogThemeData(backgroundColor: Color(0xffF0F0F0)),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Co.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
  );
}
