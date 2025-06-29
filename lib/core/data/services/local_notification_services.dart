import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const channelId = "kure";
const channelName = "Kure App";
const channelDescription = "Kure Notification Channel";

class LocalNotificationServices {
  static final _inst = LocalNotificationServices._();
  static LocalNotificationServices get inst => _inst;

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  LocalNotificationServices._() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  init() async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/ic_launcher_foreground');
    var initializationSettingsIOS = const DarwinInitializationSettings(requestProvisionalPermission: true, requestCriticalPermission: true);

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: LocalNotificationServices.notificationTapBackground,
      onDidReceiveNotificationResponse: onSelectNotification,
    );

    if (Platform.isAndroid) {
      _createAndroidNotificationChannel(channelId, channelName, channelDescription);
    }
  }

  void onSelectNotification(NotificationResponse response) {
    debugPrint(response.payload.toString());
    if (response.payload?.contains('order_id') == true) {}
  }

  var android = const AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: channelDescription,
    importance: Importance.max,
    priority: Priority.high,
    // actions: []
  );
  var ios = const DarwinNotificationDetails();
  Future showNotification(RemoteMessage message) async {
    await init();
    var platform = NotificationDetails(android: android, iOS: ios);
    debugPrint(message.data.toString());
    await _flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      platform,
      payload: jsonEncode(message.data),
    );
  }

  Future<void> _createAndroidNotificationChannel(String id, String name, String description) async {
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      name,
      description: description,
      playSound: true,
      enableLights: true,
      importance: Importance.high,
    );
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
      androidNotificationChannel,
    );
  }

  //IOS:
  //This function also requires the @pragma('vm:entry-point') annotation to ensure
  //that tree-shaking doesn't remove the code since it would be invoked on the native side.
  //You need to configure a top level or static method which will handle the action:
  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
    // debugPrint(' :::: notificationTapBackground');
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () => di<NavigationService>()
    //       .navigateTo(RouteName.notifications, arguments: {'renew': true}),
    // );
  }
}
