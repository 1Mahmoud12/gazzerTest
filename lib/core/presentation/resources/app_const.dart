import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

class AppConst {
  AppConst._();
  static final floatingCartWidth = 64.0;
  static final defaultStoreRadius = 12.0;
  static final defaultStoreBorderRadius = BorderRadius.circular(
    defaultStoreRadius,
  );
  static final defaultRadius = 16.0;
  static final defaultInnerRadius = 32.0;
  static final defaultBorderRadius = BorderRadius.circular(defaultRadius);
  static final defaultInnerBorderRadius = BorderRadius.circular(
    defaultInnerRadius,
  );
  static final defaultPadding = const EdgeInsets.all(16.0);
  static final defaultHrPadding = const EdgeInsets.symmetric(horizontal: 16.0);

  // Support contact
  static const String supportPhoneNumber = '+20123456789'; // TODO: Update with actual number

  static String notificationChannelKey = 'channel_id1';
  static String fcmToken = 'fcmToken';
  static String deviceId = 'deviceId';
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Map jsonServerKey = {};

  static RemoteMessage? messageGlobal;
}
