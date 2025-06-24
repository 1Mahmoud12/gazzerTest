import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';

class GazzerApp extends StatelessWidget {
  const GazzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainLayout(),
      navigatorKey: AppNavigator().mainKey,
      theme: AppTheme.lightTheme,
      localizationsDelegates: L10n.localizationDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: L10n.supportedLocales.first,
      builder: (context, child) {
        AppNavigator().initContext = context;
        return child!;
      },
    );
  }
}
