import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/features/gorcery/presentation/view/grocery_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GazzerApp extends StatelessWidget {
  const GazzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((v) {
      v.clear();
    });
    return MaterialApp(
      home: const GroceryScreen(),
      navigatorKey: AppNavigator().mainKey,
      theme: AppTheme.lightTheme,
      localizationsDelegates: L10n.localizationDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: L10n.supportedLocales.first,
    );
  }
}
