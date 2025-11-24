import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_state.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/notification/notification.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_router.dart';
import 'package:gazzer/core/presentation/theme/theming.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';

class GazzerApp extends StatefulWidget {
  const GazzerApp({super.key});

  @override
  State<GazzerApp> createState() => _GazzerAppState();
}

class _GazzerAppState extends State<GazzerApp> {
  int currentIndex = 0;

  @override
  void didChangeDependencies() async {
    if (currentIndex == 0) {
      await initNotification();
      await selectTokens();
      currentIndex++;
    }
    super.didChangeDependencies();
  }

  Future<void> initNotification() async {
    await Future.delayed(Duration.zero, () async {
      //setup notification callback here
      await NotificationUtility.setUpNotificationService(context);
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationUtility.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationUtility.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationUtility.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationUtility.onDismissActionReceivedMethod,
    );

    notificationTerminatedBackground();
  }

  void notificationTerminatedBackground() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint('Global Message ${AppConst.messageGlobal?.data}');
      if (AppConst.messageGlobal?.data != null) {
        debugPrint('Global Message Enter${AppConst.messageGlobal?.data}');

        Future.delayed(const Duration(milliseconds: 1000), () async {
          NotificationUtility.onTapNotificationScreenNavigateCallback(
            AppConst.messageGlobal!.data['type'] ?? '',
            AppConst.messageGlobal!.data,
          );
          AppConst.messageGlobal = null;
        });
      }
    });
  }

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
