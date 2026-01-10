import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';

class AppSnackbar {
  static void showActionSnackBar(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool forError = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: forError ? Co.red : Co.purple,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: actionLabel == null || onActionPressed == null
            ? null
            : SnackBarAction(label: actionLabel, onPressed: onActionPressed, textColor: Co.white),
        content: Text(message),
      ),
    );
  }

  static void validationError(BuildContext context, String content, {int? duration}) {
    if (content.contains("429")) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(getSnackBar(bgColor: Colors.red, content: content, icon: CupertinoIcons.exclamationmark, iconColor: Colors.red));
  }

  static void success(BuildContext context, String content) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(getSnackBar(bgColor: Colors.green, content: content, icon: Icons.done));
  }

  static void info(BuildContext context, String content) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(getSnackBar(bgColor: Co.white, content: content, icon: CupertinoIcons.exclamationmark, iconColor: Co.purple));
  }

  static void exitSnack(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // margin: EdgeInsets.only(bottom: 10),
        behavior: SnackBarBehavior.fixed,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        showCloseIcon: true,
        dismissDirection: DismissDirection.down,
        duration: const Duration(seconds: 2),
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        content: Text(L10n.tr().clickBackAgainToExit, style: context.style16400.copyWith(color: Co.white)),
      ),
    );
  }
}

SnackBar getSnackBar({required Color bgColor, required String content, required IconData icon, Color? iconColor}) {
  return SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(vertical: 10),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    closeIconColor: Co.white,
    duration: const Duration(seconds: 2),
    backgroundColor: bgColor,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 30),
        CircleAvatar(
          backgroundColor: Co.white,
          radius: 22,
          child: Icon(icon, color: iconColor ?? bgColor, size: 35, weight: 2),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            content,
            style: TStyle.robotBlackSubTitle().copyWith(color: Co.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    ),
  );
}
