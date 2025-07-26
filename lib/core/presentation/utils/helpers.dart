import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:intl/intl.dart';

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

  static String? formatDate(String? date, {bool showDate = true, bool showTime = false}) {
    if (date == null) return null;
    try {
      final parsed = DateTime.parse(date);
      final formateddate = DateFormat('MMM dd, yyyy').format(parsed);
      final formatedTime = DateFormat('jms').format(parsed);
      return showDate ? formateddate + (showTime ? ' $formatedTime' : '') : formatedTime;
    } catch (e) {
      return null;
    }
  }

  static String? countDownTime(int seconds) {
    try {
      final parsed = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
      final formatedTime = DateFormat('hh:mm:ss').format(parsed);
      return formatedTime;
    } catch (e) {
      return null;
    }
  }

  static String getProperPrice(num price, {bool showCurrency = true}) {
    final isInt = price % 1 == 0;

    return (isInt ? price.toStringAsFixed(0) : price.toStringAsFixed(2)) + (showCurrency ? (' ${L10n.tr().egp}') : '');
  }
}
