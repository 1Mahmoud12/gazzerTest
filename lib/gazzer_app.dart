import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_state.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_router.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';

class GazzerApp extends StatelessWidget {
  const GazzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppSettingsCubit(),
        ),
        BlocProvider(
          create: (context) => di<CartCubit>()..loadCart(),
        ),
        BlocProvider(
          create: (context) => di<CheckoutCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<AppSettingsCubit, AppSettingsState>(
            builder: (context, state) => MaterialApp.router(
              routerConfig: router,
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
