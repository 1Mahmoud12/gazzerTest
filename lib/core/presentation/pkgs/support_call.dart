import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

/// Comprehensive Support Call Service
/// Handles all call scenarios including SIM detection, permissions, and errors
class SupportCallService {
  /// Main method to initiate a support call
  /// Returns true if call was initiated successfully, false otherwise
  static Future<bool> callSupport(BuildContext context) async {
    try {
      // Step 1: Check if device can make calls (mobile only)
      if (!Platform.isAndroid && !Platform.isIOS) {
        Alerts.showToast(L10n.tr().unableToMakeCall);
        return false;
      }

      // Step 2: Check phone permission (Android only)
      if (Platform.isAndroid) {
        final hasPermission = await _checkPhonePermission(context);
        if (!hasPermission) {
          return false;
        }
      }

      // Step 3: Attempt to make the call
      return await _makeCall(context, AppConst.supportPhoneNumber);
    } catch (e) {
      if (kDebugMode) {
        print('Error calling support: $e');
      }
      Alerts.showToast(L10n.tr().callFailed);
      return false;
    }
  }

  /// Check and request phone permission (Android only)
  static Future<bool> _checkPhonePermission(BuildContext context) async {
    try {
      // Check current permission status
      PermissionStatus status = await Permission.phone.status;

      if (status.isGranted) {
        return true;
      }

      if (status.isDenied) {
        // Request permission
        status = await Permission.phone.request();

        if (status.isGranted) {
          return true;
        } else if (status.isDenied && context.mounted) {
          Alerts.showToast(L10n.tr().unableToMakeCall);
          return false;
        }
      }

      if (status.isPermanentlyDenied && context.mounted) {
        // Show dialog to open settings
        _showPermissionSettingsDialog(context);
        return false;
      }

      return false;
    } catch (e) {
      // If permission check fails, try to make the call anyway
      // url_launcher will handle the permission on its own
      if (kDebugMode) {
        print('Permission check failed: $e');
      }
      return true;
    }
  }

  /// Make the actual phone call
  static Future<bool> _makeCall(
    BuildContext context,
    String phoneNumber,
  ) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      // Check if the device can handle tel: scheme
      if (await canLaunchUrl(telUri)) {
        // Show info toast
        Alerts.showToast(L10n.tr().callingSupport, isInfo: true);

        // Launch the phone dialer
        final launched = await launchUrl(
          telUri,
          mode: LaunchMode.externalApplication,
        );

        if (!launched && context.mounted) {
          Alerts.showToast(L10n.tr().unableToMakeCall);
          return false;
        }

        return true;
      } else {
        // Device doesn't support phone calls (tablets, etc.)
        if (context.mounted) {
          Alerts.showToast(L10n.tr().unableToMakeCall);
        }
        return false;
      }
    } catch (e) {
      // Handle any errors
      if (kDebugMode) {
        print('Call failed: $e');
      }
      if (context.mounted) {
        Alerts.showToast(L10n.tr().callFailed);
      }
      return false;
    }
  }

  /// Show dialog to open app settings for permission
  static void _showPermissionSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialogs.confirmDialog(
        title: L10n.tr().warning,
        message: L10n.tr().unableToMakeCall,
        context: context,
        okBtn: L10n.tr().confirm,
        cancelBtn: L10n.tr().cancel,
        okBgColor: Co.purple,
        cancelBgColor: Co.grey,
      ),
    ).then((result) {
      if (result == true) {
        openAppSettings();
      }
    });
  }

  /// Show dialog with call options (useful for dual SIM devices)
  /// This allows users to see the number before calling
  static void showCallOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Co.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VerticalSpacing(20),
                Text(
                  L10n.tr().contactUs,
                  style: TStyle.blackBold(18),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpacing(10),
                Text(
                  L10n.tr().callSupport,
                  style: TStyle.greyRegular(14),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpacing(10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Co.purple.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, color: Co.purple, size: 20),
                      const HorizontalSpacing(8),
                      Text(
                        AppConst.supportPhoneNumber,
                        style: TStyle.primaryBold(16),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(10),
                Text(
                  L10n.tr().support,
                  style: TStyle.greyRegular(12),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: MainBtn(
                          text: L10n.tr().cancel,
                          bgColor: Co.greyText,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                      const HorizontalSpacing(20),
                      Expanded(
                        child: MainBtn(
                          text: L10n.tr().callSupport,
                          bgColor: Co.purple,
                          onPressed: () {
                            context.pop();
                            callSupport(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
