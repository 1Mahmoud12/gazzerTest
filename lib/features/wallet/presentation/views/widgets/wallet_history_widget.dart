import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/wallet/presentation/views/wallet_history_screen.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/wallet_history_tile.dart';

class WalletHistoryWidget extends StatelessWidget {
  const WalletHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    final entries = [
      WalletHistoryEntry(
        title: l10n.walletRefund,
        subtitle: l10n.walletValidUntil('23\\2\\2025'),
        date: '11\\11\\2025',
        time: '04:34 PM',
        amount: 500,
      ),
      WalletHistoryEntry(
        title: l10n.walletRecharge,
        subtitle: l10n.walletCardPayment,
        date: '11\\11\\2025',
        time: '04:34 PM',
        amount: 500,
      ),
      WalletHistoryEntry(
        title: l10n.walletPointsConversion,
        subtitle: l10n.walletCardPayment,
        date: '11\\11\\2025',
        time: '04:34 PM',
        amount: 500,
      ),
      WalletHistoryEntry(
        title: l10n.walletOrderNumber('345778'),
        subtitle: l10n.walletCardPayment,
        date: '11\\11\\2025',
        time: '04:34 PM',
        amount: -500,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithMore(
          title: l10n.walletHistory,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WalletHistoryScreen(entries: entries),
              ),
            );
          },
        ),

        const SizedBox(height: 16),
        Column(
          children: [
            for (int i = 0; i < entries.length; i++) ...[
              WalletHistoryTile(entry: entries[i]),
              if (i != entries.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ],
    );
  }
}
