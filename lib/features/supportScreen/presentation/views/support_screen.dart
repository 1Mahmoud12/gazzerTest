import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

import 'faq_list_screen.dart';
import 'order_issue_screen.dart';
import 'widgets/support_option_tile.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  static const route = '/support-screen';

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.support),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SupportOptionTile(
              title: l10n.orderIssue,
              onTap: () {
                context.navigateToPage(const OrderIssueScreen());
              },
            ),
            const VerticalSpacing(12),
            SupportOptionTile(
              title: 'General Issue - Inquiry',
              onTap: () {
                context.navigateToPage(
                  const FaqListScreen(
                    args: FaqListArgs(title: 'General Issue - Inquiry'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
