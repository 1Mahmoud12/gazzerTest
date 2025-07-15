import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_state.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/features/splash/view/splash_screen.dart';

class GazzerApp extends StatelessWidget {
  const GazzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingsCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<AppSettingsCubit, AppSettingsState>(
            builder: (context, state) => MaterialApp(
              home: const SplashScreen(),
              navigatorKey: AppNavigator().mainKey,
              theme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: L10n.localizationDelegates,
              supportedLocales: L10n.supportedLocales,
              locale: Locale(state.lang),
            ),
          );
        },
      ),
    );
  }
}
