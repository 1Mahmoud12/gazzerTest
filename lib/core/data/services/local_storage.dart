import 'package:flutter/foundation.dart';
import 'package:gazzer/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static String locale = 'locale';
  static String isDark = 'isDark';
  static String token = 'token';
  // static String user = "user";
  static String haveSeenTour = 'haveSeenTour';
  static String fcmTokenTime = 'fcmTokenTime';
  static String readNotifications = 'readNotifications';
  static String favoriteIDs = 'readNotifications';
  static String cart = 'cart';
  static String deviceId = 'device_id';
  static String fcmToken = 'fcm_token';
  // static String branchId = "branchId";
}

/// Centralized cache keys for API response caching
class CacheKeys {
  CacheKeys._();

  // Categories Widget
  static const String categoriesWidgetJson = 'categories_widget_json';
  static const String categoriesWidgetTs = 'categories_widget_ts';

  // Top Items
  static const String topItemsJson = 'top_items_json';
  static const String topItemsTs = 'top_items_ts';

  // Suggests
  static const String suggestsJson = 'suggests_json';
  static const String suggestsTs = 'suggests_timestamp';

  // Daily Offers
  static const String dailyOffersJson = 'daily_offers_json';
  static const String dailyOffersTs = 'daily_offers_ts';

  // Loyalty Program
  static const String loyaltyProgramCache = 'loyalty_program_json';
  static const String loyaltyProgramTs = 'loyalty_program_timestamp';

  // Orders
  static const String ordersCache = 'client_orders_json';
  static const String ordersTs = 'client_orders_timestamp';
  static const String orderDetailCachePrefix = 'order_detail_';

  // Wallet
  static const String walletCache = 'wallet_json';
  static const String walletTs = 'wallet_timestamp';
  static const String walletTransactionsCache = 'wallet_transactions_json';
  static const String walletTransactionsTs = 'wallet_transactions_timestamp';

  // FAQ
  static const String faqCategoriesJsonPrefix = 'faq_categories_json_';
  static const String faqCategoriesTsPrefix = 'faq_categories_ts_';
}

class TokenService {
  TokenService._();
  static String? getToken() {
    final tok = di<SharedPreferences>().getString(StorageKeys.token);
    debugPrint('get Token $tok');
    return tok;
  }

  static Future<bool> setToken(String token) async {
    debugPrint('setToken $token');
    return await di<SharedPreferences>().setString(StorageKeys.token, token);
  }

  static Future<bool> deleteToken() async {
    return await di<SharedPreferences>().remove(StorageKeys.token);
  }
}
