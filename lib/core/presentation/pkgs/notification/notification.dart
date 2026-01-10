import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/presentation/pkgs/notification/device_id.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/views/gazzer_support_chat_screen.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NotificationType { support, SaleBill, ReturnSaleBill, visit, VecationRequest, PrivilegeCard, Client, DelegateSettlement, ProductInternalMove }

// ignore: avoid_classes_with_only_static_members
class NotificationUtility {
  static String generalNotificationType = 'general';

  static String assignmentNotificationType = 'assignment';
  static RemoteMessage? remoteMessageGlobal;
  static AwesomeNotifications awesomeNotification = AwesomeNotifications();

  static Future<void> setUpNotificationService(BuildContext buildContext) async {
    NotificationSettings notificationSettings = await AppConst.messaging.getNotificationSettings();
    //ask for permission
    if (notificationSettings.authorizationStatus == AuthorizationStatus.notDetermined ||
        notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      notificationSettings = await AppConst.messaging.requestPermission(
        //provisional: true,
        announcement: true,
      );

      //if permission is provisionnal or authorised
      if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized ||
          notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
        if (buildContext.mounted) {
          debugPrint('===== 1 ======');
          initNotificationListener(buildContext);
        }
      }

      //if permission denied
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    if (buildContext.mounted) {
      debugPrint('===== 2 ======');
      initNotificationListener(buildContext);
    }
  }

  static int count = 0;

  static void initNotificationListener(BuildContext buildContext) {
    AppConst.messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen((remoteMessage) async {
      if (Platform.isAndroid) {
        createLocalNotification(dismissible: true, message: remoteMessage);
      }
      // BlocProvider.of<HomeCubit>( AppNavigator.mainKey.currentState!.context).getNotificationCount();

      debugPrint('remoteMessage===>${remoteMessage.toMap()}');

      // Increment notification count in UI when app is in foreground
      try {
        //  final context = AppNavigator.mainKey.currentState?.context;
        // if (context != null) {
        //  MainCubit.of(context).incrementNotificationCount();
        // }
      } catch (e) {
        debugPrint('Failed to increment notification count: $e');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      log('onMessageOpenedAppListener');

      if (count == 0) {
        onMessageOpenedAppListener(remoteMessage);
        onTapNotificationScreenNavigateCallback(remoteMessage.data['type'] ?? '', remoteMessage.data);
        //   BlocProvider.of<HomeCubit>( AppNavigator.mainKey.currentState!.context).getNotificationCount();

        count++;
        Future.delayed(const Duration(seconds: 4), () {
          log('count cdelayed');

          count = 0;
        });
      }

      log('count count $count');
    });
  }

  static Future<void> onBackgroundMessage(RemoteMessage remoteMessage) async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // ).then((value) {
    //   FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    // });

    //onMessageOpenedAppListener(remoteMessage);
    /* if (Platform.isAndroid) {
      createLocalNotification(dimissable: true, message: remoteMessage);
    }*/

    //perform any background task if needed here
    /*remoteMessageGlobal = remoteMessage;
    debugPrint('_onTapNotificationScreenNavigateCallback BackGround $remoteMessageGlobal');

    onTapNotificationScreenNavigateCallback(
      remoteMessage.dataSource['type'] ?? '',
      remoteMessage.dataSource,
    );*/
  }

  /*  static Future<void> foregroundMessageListener(
    RemoteMessage remoteMessage,
  ) async {
    await AppConst.messaging.getToken();
    createLocalNotification(dimissable: true, message: remoteMessage);
  }*/

  static void onMessageOpenedAppListener(RemoteMessage remoteMessage) {
    debugPrint('onMessageOpenedAppListener $remoteMessage');

    onTapNotificationScreenNavigateCallback(remoteMessage.data['type'] ?? '', remoteMessage.data);
  }

  static void onTapNotificationScreenNavigateCallback(String notificationType, Map<String, dynamic> data) async {
    debugPrint('onTapNotificationScreenNavigateCallback $data');

    if (notificationType.toLowerCase() == NotificationType.support.name) {
      log('======== SupportScreen =======');

      // Extract chat_id and order_id from notification data
      final int? chatId = _extractIntFromData(data, 'chat_id') ?? _extractIntFromData(data, 'chatId');
      final int? orderId = _extractIntFromData(data, 'order_id') ?? _extractIntFromData(data, 'orderId');

      AppNavigator.mainKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => GazzerSupportChatScreen(chatId: chatId, orderId: orderId),
        ),
      );
    } else {}
  }

  static int? _extractIntFromData(Map<String, dynamic> data, String key) {
    if (!data.containsKey(key)) return null;
    final value = data[key];
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /*static Future<bool> isLocalNotificationAllowed() async {
    const notificationPermission = Permission.notification;
    final status = await notificationPermission.status;
    return status.isGranted;
  }*/

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('===ACTION RECEIVED===');

    debugPrint("${receivedAction.payload?['data']}");

    final data = jsonDecode(receivedAction.payload!['data']!)['data'];
    final notificationType = (data['type'] ?? '').toLowerCase();

    if (notificationType.toLowerCase() == NotificationType.support.name) {
      log('======== SupportScreen =======');

      // Extract chat_id and order_id from notification data
      final int? chatId = _extractIntFromData(data, 'chat_id') ?? _extractIntFromData(data, 'chatId');
      final int? orderId = _extractIntFromData(data, 'order_id') ?? _extractIntFromData(data, 'orderId');

      AppNavigator.mainKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => GazzerSupportChatScreen(chatId: chatId, orderId: orderId),
        ),
      );
    } else {}
  }

  static Future<void> sendMessageNotification({required String namePerson, required String body, required String tokenUser}) async {
    try {
      final Response response = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAcQAIiSY:APA91bHPRzIe__QC3eOtgvTce0FLo_crabHtjFDYazI212td_Aj3flr3LqCYFDcZDL4asKAX9-RYrrDJP6mtesucuB3ksOfiAwbPX97DJMpwp52wjaoLxB4h50r-kaJXbIo6wOfTP6-8',
        },
        body: jsonEncode({
          'notification': <String, dynamic>{'title': namePerson, 'body': body, 'sound': 'alarm'},
          'priority': 'high',
          //'data': <String, dynamic>{'click_action': action, 'token': tokenMeeting, 'User': jsonEncode(modelUser.toMap()), 'status': 'done'},
          'to': tokenUser,
        }),
      );

      debugPrint(jsonDecode(response.body));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> initializeAwesomeNotification() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: AppConst.notificationChannelKey,
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.High,
        channelShowBadge: true,
        playSound: true,
      ),
    ]);
  }

  static Future<void> createLocalNotification({required bool dismissible, required RemoteMessage message}) async {
    final String title = message.notification?.title ?? message.data['title'] ?? 'no title ';
    final String body = message.notification?.body ?? message.data['body'] ?? 'no body found';
    //  final String? image = message.toMap()['notification']['android']['imageUrl'];
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        autoDismissible: dismissible,
        title: title,
        body: body,
        id: 1,
        locked: !dismissible,

        payload: {'data': jsonEncode(message.toMap())},
        channelKey: AppConst.notificationChannelKey,

        customSound: 'resource://raw/notification',
        wakeUpScreen: true,
        //  largeIcon: image,
        roundedLargeIcon: true,
        hideLargeIconOnExpand: true,
        //bigPicture: image,
        //notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}

Future<Map> loadJsonFile() async {
  final String response = await rootBundle.loadString('assets/services/gazar-21127-firebase-adminsdk-j5y44-5ac7ce9b3e.json');
  final data = json.decode(response);
  return data;
}

Future<void> sendFCMMessage({
  required String token,
  required String title,
  required String body,
  required String type,
  Map<String, dynamic>? data,
}) async {
  //  final serviceAccountFile = File('assets/services/codgoo-12e2d-firebase-adminsdk-gxigy-d3e7342fc4.json');
  // final serviceAccountJson = json.decode(await serviceAccountFile.readAsString());

  final accountCredentials = ServiceAccountCredentials.fromJson(AppConst.jsonServerKey);

  final authClient = await clientViaServiceAccount(accountCredentials, ['https://www.googleapis.com/auth/firebase.messaging']);
  final serverKey = authClient.credentials.accessToken.data; // FCM message payload
  data ?? {}.addAll({'title': title, 'body': body, 'type': type});
  final message = jsonEncode({
    'message': {
      'token': token,
      'dataSource': data,
      'notification': {
        'body': 'to_client',
        'title': 'notification',
        // "image": "https://dummyimage.com/96x96.png"
        // "sound":"notification.aac"
      },
      'apns': {
        'payload': {
          'aps': {'mutable-content': 1, 'sound': 'notification.wav'},
        },
      },
      // "mutable_content": true,
    },
  });

  // Send the FCM request
  final response = await authClient.post(
    Uri.parse('https://fcm.googleapis.com/v1/projects/codgoo-12e2d/messages:send'),
    headers: {'Authorization': 'Bearer $serverKey', 'Content-Type': 'application/json'},
    body: message,
  );

  if (response.statusCode == 200) {
    log('FCM message sent successfully ${response.body}');
  } else {
    log('FCM message failed: ${response.statusCode} ${response.body}');
  }
}

Future<void> selectTokens() async {
  AppConst.messaging.requestPermission(
    // provisional: true,
    announcement: true,
  );
  if (Platform.isIOS) {
    await AppConst.messaging.requestPermission(
      //provisional: true,
      announcement: true,
    );
    await AppConst.messaging.getAPNSToken();
  }
  final String newToken = await AppConst.messaging.getToken() ?? '';
  if (newToken != AppConst.fcmToken) {
    log('Need Get Token');
    AppConst.fcmToken = newToken;
    AppConst.deviceId = await DeviceUUid().getUniqueDeviceId();
    if (Session().client != null) {
      //HomeDataSourceImpl().updateFcmToken(fcmToken: AppConst.fcmToken, deviceId: AppConst.deviceId);
    }

    // Save to SharedPreferences
    final prefs = di<SharedPreferences>();
    await prefs.setString(StorageKeys.fcmToken, AppConst.fcmToken);
    await prefs.setString(StorageKeys.deviceId, AppConst.deviceId);
  }
  debugPrint('Device Id ===> ${AppConst.deviceId}');
  debugPrint('FCM ===> ${AppConst.fcmToken}');
}
