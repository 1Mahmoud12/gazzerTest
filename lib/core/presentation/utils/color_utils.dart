import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/repos/crashlytics_repo.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/di.dart';

class ColorUtils {
  /// Converts a hex string to a Color object
  /// Supports formats: #RRGGBB, #AARRGGBB, RRGGBB, AARRGGBB
  /// Examples: "#FF5733", "#80FF5733", "FF5733", "80FF5733"
  static Color? _hexToColor(String hexString) {
    // Remove # if present
    hexString = hexString.replaceAll('#', '');

    // If it's 6 characters, add FF for full opacity
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }

    // Parse the hex string
    if (hexString.length == 8) {
      final hex = int.tryParse('0x$hexString');
      return hex == null ? null : Color(hex);
    } else {
      throw ArgumentError('Invalid hex color format: $hexString');
    }
  }

  // /// Alternative method with default opacity
  // static Color hexToColorWithOpacity(String hexString, {double opacity = 1.0}) {
  //   hexString = hexString.replaceAll('#', '');

  //   if (hexString.length == 6) {
  //     final color = Color(int.parse('0xFF$hexString'));
  //     return color.withOpacity(opacity);
  //   } else if (hexString.length == 8) {
  //     return Color(int.parse('0x$hexString'));
  //   } else {
  //     throw ArgumentError('Invalid hex color format: $hexString');
  //   }
  // }

  /// Safe conversion that returns a default color if parsing fails
  static Color safeHexToColor(String? hexString, {Color defaultColor = Co.purple100}) {
    if (hexString == null || hexString.isEmpty) return defaultColor;
    try {
      final val = _hexToColor(hexString);
      return val ?? defaultColor;
    } catch (e, stack) {
      di<CrashlyticsRepo>().sendToCrashlytics(e, stack);
      return defaultColor;
    }
  }
}
