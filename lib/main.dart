import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/pkgs/notification/notification.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/utils/bloc_observer.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/firebase_options.dart';
import 'package:gazzer/gazzer_app.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Helpers.customTryCatch(() async => await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationUtility.initializeAwesomeNotification();
  try {
    AppConst.messageGlobal = await FirebaseMessaging.instance.getInitialMessage();
    if (AppConst.messageGlobal?.data != null) {
      AppNavigator.initialRoute = '/';
    }
    log('appStartScreen ${AppNavigator.initialRoute}');
  } catch (error) {
    log('$error');
  }
  Bloc.observer = MyBlocObserver();
  await init();
  runApp(const GazzerApp());
}
