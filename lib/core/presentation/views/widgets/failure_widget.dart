import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, this.message, this.image, this.onRetry});
  final String? message;
  final String? image;
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null) Image.asset(image!),
          if (message != null) Text(message!, style: TStyle.errorSemi(14), textAlign: TextAlign.center),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: Text(L10n.tr().retry),
            ),
        ],
      ),
    );
  }
}
