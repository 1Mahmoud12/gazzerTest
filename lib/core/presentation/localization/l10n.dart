import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gazzer/core/presentation/localization/app_localizations.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';

class L10n {
  L10n._();

  static final List<Locale> supportedLocales = [const Locale('ar', ''), const Locale('en', '')];

  static const List<LocalizationsDelegate> localizationDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static Locale? setFallbackLocale(deviceLocale, _) {
    final List<String> supportedLangCodes = supportedLocales.map((e) => e.languageCode).toList();
    final String deviceLangCode = deviceLocale.toString().substring(0, 2);
    if (!supportedLangCodes.contains(deviceLangCode)) {
      return supportedLocales[0];
    }
    return null;
  }

  static AppLocalizations tr([BuildContext? ctx]) => AppLocalizations.of(ctx ?? AppNavigator.mainKey.currentContext!)!;

  static bool isAr(BuildContext context) => Localizations.localeOf(context).languageCode == 'ar';
}
