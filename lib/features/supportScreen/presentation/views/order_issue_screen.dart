import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

import 'missing_items_screen.dart';
import 'widgets/order_issue_option_tile.dart';

class OrderIssueScreen extends StatelessWidget {
  const OrderIssueScreen({
    super.key,
    this.orderId,
  });

  final int? orderId;

  static const route = '/order-issue';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.orderIssue),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OrderIssueOptionTile(
              title: l10n.missingOrIncorrectItems,
              onTap: () {
                if (orderId != null) {
                  context.navigateToPage(
                    MissingItemsScreen(orderId: orderId!),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order ID is required'),
                    ),
                  );
                }
              },
            ),
            const VerticalSpacing(12),
            OrderIssueOptionTile(
              title: l10n.wholeOrderIsWrong,
              onTap: () {
                // TODO: Implement specific order issue flow
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${l10n.wholeOrderIsWrong} - Coming soon'),
                  ),
                );
              },
            ),
            const VerticalSpacing(12),
            OrderIssueOptionTile(
              title: l10n.qualityIssue,
              onTap: () {
                // TODO: Implement specific order issue flow
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${l10n.qualityIssue} - Coming soon')),
                );
              },
            ),
            const VerticalSpacing(12),
            OrderIssueOptionTile(
              title: l10n.issueWithDeliveryMan,
              onTap: () {
                // TODO: Implement specific order issue flow
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${l10n.issueWithDeliveryMan} - Coming soon'),
                  ),
                );
              },
            ),
            const VerticalSpacing(12),
            OrderIssueOptionTile(
              title: l10n.paymentAndRefund,
              onTap: () {
                // TODO: Implement specific order issue flow
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${l10n.paymentAndRefund} - Coming soon'),
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
