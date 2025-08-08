import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';

abstract class Helpers {
  static Future customTryCatch(Future Function() func) async {
    try {
      await func();
    } catch (e, stack) {
      if (kDebugMode) {
        print(e.toString());
      } else {
        FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      }
    }
  }

  static String getProperPrice(num price, {bool showCurrency = true}) {
    final isInt = price % 1 == 0;

    return (isInt ? price.toStringAsFixed(0) : price.toStringAsFixed(2)) + (showCurrency ? (' ${L10n.tr().egp}') : '');
  }

  static String formatTimeSlot(String time) {
    try {
      final parts = time.split(':');
      final hours = int.parse(parts[0]);
      final suffix = hours >= 12 ? L10n.tr().pm : L10n.tr().am;
      final formattedHours = hours % 12 == 0 ? 12 : hours % 12; // Convert to 12-hour format
      return '$formattedHours:${parts[1]} $suffix';
    } catch (e) {
      return time; // Return the original time if parsing fails
    }
  }
}
