import 'package:flutter/foundation.dart';
import 'package:gazzer/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static String locale = "locale";
  // static String lightTheme = "lightTheme";
  static String token = "token";
  // static String user = "user";
  static String isRevist = "revist";
  static String fcmTokenTime = "fcmTokenTime";
  static String readNotifications = "readNotifications";
  static String favoriteIDs = "readNotifications";
  static String cart = "cart";
  // static String branchId = "branchId";
}

class TokenService {
  TokenService._();
  static String? getToken() {
    final tok = di<SharedPreferences>().getString(StorageKeys.token);
    debugPrint("get Token $tok");
    return tok;
  }

  static Future<bool> setToken(String token) async {
    debugPrint("setToken $token");
    return await di<SharedPreferences>().setString(StorageKeys.token, token);
  }

  static Future<bool> deleteToken() async {
    return await di<SharedPreferences>().remove(StorageKeys.token);
  }
}
