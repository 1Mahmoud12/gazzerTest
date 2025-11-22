import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

import 'gazzer_support_screen.dart';
import 'widgets/feedback_bottom_sheet.dart';

class OrderIssueResponseScreen extends StatelessWidget {
  const OrderIssueResponseScreen({super.key});

  static const route = '/order-issue-response';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Scaffold(
      appBar: MainAppBar(
        title: l10n.missingOrIncorrectItems,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.weHaveChecked,
              style: TStyle.robotBlackSubTitle(),
            ),
            const VerticalSpacing(16),
            Text(
              l10n.orderIssueOutsideRefundWindow,
              style: TStyle.blackRegular(14),
            ),
            const VerticalSpacing(12),
            Text(
              l10n.contactUsAsSoonAsPossible,
              style: TStyle.blackRegular(14),
            ),
            const Spacer(),
            Center(
              child: Text(
                l10n.wasThisHelpful,
                style: TStyle.blackBold(14).copyWith(color: Co.purple),
              ),
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => showFeedbackBottomSheet(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(l10n.yes),
                  ),
                ),
                const HorizontalSpacing(12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.navigateToPage(const GazzerSupportScreen());
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(l10n.no),
                  ),
                ),
              ],
            ),
            const VerticalSpacing(16),
          ],
        ),
      ),
    );
  }
}
