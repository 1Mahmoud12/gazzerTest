import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';

class DeleteAccountConfirmSheet extends StatelessWidget {
  const DeleteAccountConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(text: L10n.tr().confirmToDelete, style: TStyle.primaryBold(24)),
            ],
          ),
          OutlinedButton(
            onPressed: () {
              context.myPop(result: true);
            },
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(250, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(L10n.tr().deleteAccount, style: TStyle.primaryBold(14)),
          ),
        ],
      ),
    );
  }
}
