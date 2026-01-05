import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/support_call.dart';

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

    return (isInt ? price.toStringAsFixed(0) : price.toStringAsFixed(1)) + (showCurrency ? ' ${L10n.tr().egp}' : '');
  }

  static String formatTimeSlot(String time) {
    try {
      final parts = time.split(':');
      final hours = int.parse(parts[0]);
      final suffix = hours >= 12 ? L10n.tr().pm : L10n.tr().am;
      final formattedHours = hours % 12 == 0 ? 12 : hours % 12; // Convert to 12-hour format
      return '$formattedHours:${parts[1].replaceAll(RegExp('[a-zA-Z]'), '')} $suffix';
    } catch (e) {
      return time; // Return the original time if parsing fails
    }
  }

  static String? shortIrretableStrings(Iterable<String> list, int length) {
    if (list.isEmpty) return null;
    final shortTag = StringBuffer(list.first);
    for (var i = 1; i < list.length; i++) {
      if (list.elementAt(i).length + shortTag.length < length) {
        shortTag.write(', ${list.elementAt(i)}');
      } else {
        shortTag.write(', ...');
        break;
      }
    }
    return shortTag.toString();
  }

  /// used mainly to form the delivery time range
  /// [edge] must be value between 0-1, [value] must be positive
  static String convertIntToRange(int value, double edge) {
    assert(value >= 0 && edge > 0 && edge < 1, 'Value must be positive and edge must be between 0 and 1');
    return '${(value * (1 - edge)).floor()} - ${(value * 1.3).ceil()} ';
  }

  /// Call support with comprehensive error handling
  /// Handles all scenarios: SIM availability, permissions, airplane mode, dual SIM, call cancellation
  /// Returns true if call was initiated successfully
  static Future<bool> callSupport(BuildContext context) async {
    return await SupportCallService.callSupport(context);
  }

  /// Show dialog with call options (useful for dual SIM devices)
  /// This allows users to see the number before calling
  static void showCallOptionsDialog(BuildContext context) {
    SupportCallService.showCallOptionsDialog(context);
  }
}
