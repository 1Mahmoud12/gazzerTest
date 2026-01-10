// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:gazzer/core/data/services/local_notification_services.dart';

// import 'package:provider/provider.dart';

class FCMService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final _inst = FCMService._();
  factory FCMService() => _inst;

  FCMService._() {
    LocalNotificationServices.inst;
    _init();
  }

  void _init() async {
    _fcm.setAutoInitEnabled(true);
    await _fcm.requestPermission(criticalAlert: true, announcement: true);
    // only for ios as andoid won't show pop up notification whilst foreground
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification in ios
      badge: true,
      sound: true,
    );
  }

  // String? fcmToken;
  Future<String> getDeviceToken() async {
    String? fcmToken;
    try {
      fcmToken = await _fcm.getToken();
      debugPrint(' ########### FCM is ::::: $fcmToken');
    } catch (e) {
      debugPrint('FCM ERROR: $e');
    }
    return fcmToken ?? '';
  }

  // Future<String?> regenrateToken() async {
  //   String? fcmToken;
  //   try {
  //     await _fcm.deleteToken();
  //     fcmToken = await getDeviceToken();
  //     final time = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //     di<SharedPreferences>().setString(StorageKeys.fcmTokenTime, time);
  //     debugPrint('set fcmTokendate');
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return fcmToken;
  // }

  void fcmForegroundHandler() async {
    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint('fcmForegroundHandler');
      debugPrint(message.data.toString());
      if (!Platform.isIOS) {
        await LocalNotificationServices.inst.showNotification(message);
      }
    });
  }

  void fcmBackgroundOpenedAppHandler() {
    debugPrint('fcmBackgroundOpenedAppHandler');
    // Returns a [Stream] that is called when a user presses a notification message displayed via FCM
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint(message.data.toString());
      if (message.data.isNotEmpty) {}
    });
  }

  void fcmOnBackground() {
    debugPrint('fcmBackgroundOpenedAppHandler');
    // Returns a [Stream] that is called when a user presses a notification message displayed via FCM
    FirebaseMessaging.onBackgroundMessage((message) async {
      debugPrint(message.data.toString());
      if (message.data.isNotEmpty) {}
    });
  }

  @pragma('vm:entry-point')
  static Future<bool> fcmTerminatedStateApp() async {
    final RemoteMessage? message = await FCMService()._fcm.getInitialMessage();
    if (message?.data.isNotEmpty == true) {
      debugPrint(message?.data.toString());
    }
    return false;
  }

  Future<void> fcmGetInitMessage() async {
    debugPrint('fcmGetInitMessage');
    fcmForegroundHandler();
    fcmOnBackground();
    fcmBackgroundOpenedAppHandler();
  }
}
