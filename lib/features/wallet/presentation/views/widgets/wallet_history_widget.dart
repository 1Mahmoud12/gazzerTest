import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/date_time.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/presentation/views/wallet_history_screen.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/wallet_history_tile.dart';
import 'package:intl/intl.dart';

class WalletHistoryWidget extends StatelessWidget {
  const WalletHistoryWidget({super.key, required this.transactions});

  final List<TransactionEntity> transactions;

  List<WalletHistoryEntry> _convertTransactionsToEntries(List<TransactionEntity> transactions) {
    final l10n = L10n.tr();
    return transactions.map((transaction) {
      String title;
      String subtitle;
      String iconAssets;

      switch (transaction.type.toLowerCase()) {
        case 'deposit':
          if (transaction.source == 'loyalty_points') {
            title = l10n.walletPointsConversion;
            subtitle = transaction.note ?? '';
            iconAssets = Assets.convertPointsIc;
          } else {
            title = l10n.walletRecharge;
            subtitle = transaction.note ?? '';
            iconAssets = Assets.rechargeIc;
          }

          break;
        case 'withdrawal':
          title = l10n.paid;
          subtitle = transaction.note ?? '';
          iconAssets = Assets.paidIc;

          break;
        case 'adjustment':
          title = l10n.paid;
          subtitle = transaction.note ?? '';
          iconAssets = Assets.convertPointsIc;

          break;
        default:
          iconAssets = Assets.rechargeIc;

          title = transaction.type;
          subtitle = transaction.note ?? '';
      }

      final date = DateFormat('dd\\MM\\yyyy').format(transaction.createdAt);
      final time = transaction.createdAt.defaultTimeFormat;

      return WalletHistoryEntry(title: title, subtitle: subtitle, date: date, time: time, amount: transaction.amount.toInt(), iconAsset: iconAssets);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    final entries = _convertTransactionsToEntries(transactions);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithMore(
          title: l10n.walletHistory,
          onPressed: entries.isEmpty
              ? null
              : () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WalletHistoryScreen()));
                },
        ),
        const SizedBox(height: 16),
        if (entries.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(l10n.walletHistorySubtitle, style: context.style16400.copyWith(color: Co.grey)),
            ),
          )
        else
          Column(
            children: [
              for (int i = 0; i < entries.length && i < 3; i++) ...[
                WalletHistoryTile(entry: entries[i]),
                if (i != entries.length - 1 && i < 2) const SizedBox(height: 12),
              ],
            ],
          ),
      ],
    );
  }
}
