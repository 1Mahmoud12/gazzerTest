import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class FailureComponent extends StatelessWidget {
  const FailureComponent({super.key, this.message, this.onRetry});
  final String? message;
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VerticalSpacing(8),
          Image.asset(Assets.assetsPngError, height: 200, fit: BoxFit.contain),
          Text(L10n.tr().oops, style: TStyle.primaryBold(24)),
          const Row(),
          if (message != null) Text(message!, style: TStyle.blackBold(16), textAlign: TextAlign.center),
          if (onRetry != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MainBtn(
                  onPressed: onRetry!,
                  bgColor: Co.secondary,
                  radius: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  text: L10n.tr().tryAgain,
                  textStyle: TStyle.primaryBold(14),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
