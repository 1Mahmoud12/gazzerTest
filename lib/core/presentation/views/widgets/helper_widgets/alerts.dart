import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
// import 'package:panara_dialogs/panara_dialogs.dart';

class Alerts {
  static void exitSnack(BuildContext context, {String? msg}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.63, right: 8, left: 8),
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 2),
        backgroundColor: Co.dark.withAlpha(175),
        content: Text(msg ?? L10n.tr().pressDoubleBackToExit, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
      ),
    );
  }

  static void exitBanner(BuildContext context, {String? msg}) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text(L10n.tr().cancel, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
          ),
        ],

        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        // showCloseIcon: true,

        // dismissDirection: DismissDirection.up,
        // duration: const Duration(seconds: 2),
        backgroundColor: Co.dark,
        content: Text(msg ?? L10n.tr().pressDoubleBackToExit, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
      ),
    );
  }

  static void showToast(String message, {Toast? length, ToastGravity toastGravity = ToastGravity.BOTTOM, bool error = true, bool isInfo = false}) {
    if (message.isEmpty) return;
    Fluttertoast.showToast(
      msg: message,
      toastLength: length ?? (message.length > 35 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT),
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: 16,
      backgroundColor: isInfo
          ? Colors.blueGrey.withAlpha(125)
          : error
          ? Co.red
          : Co.secText,
      textColor: error || isInfo ? Co.white : Co.darkPurple,
    );
  }

  // static void locationDisabled() {
  //   final context = AppConsts.navigatorKey.currentContext!;
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialogs.confirmDialog(
  //       title: L10n.tr().attention,
  //       message: L10n.tr().pleaseEnableLocationService,
  //     ),
  //   );
  // }
}
