import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/intro_video_tutorial_screen.dart';

class GazzerApp extends StatelessWidget {
  const GazzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const IntroVideoTutorialScreen(videoLink: ''),
      navigatorKey: AppConst.navKey,
      theme: AppTheme.lightTheme,
      localizationsDelegates: L10n.localizationDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: L10n.supportedLocales.first,
      // builder: (context, child) {
      //   return child!;
      // },
    );
  }
}
