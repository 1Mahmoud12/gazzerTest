import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';

class WalletHistoryWidget extends StatelessWidget {
  const WalletHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    final entries = [
      _WalletHistoryEntry(
        title: l10n.walletRefund,
        subtitle: l10n.walletValidUntil('23\\2\\2025'),
        date: '11\\11\\2025',
        time: '04:34 PM',
        amount: 500,
      ),
      _WalletHistoryEntry(
        title: l10n.walletRecharge,
        subtitle: l10n.walletCardPayment,
        date: '11\\11\\2025',
        time: '04:34 PM',
        amount: 500,
      ),
      _WalletHistoryEntry(
        title: l10n.walletPointsConversion,
        subtitle: l10n.walletCardPayment,
        date: '11\\11\\2025',
        time: '04:34 PM',
        amount: 500,
      ),
      _WalletHistoryEntry(
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
            //  context.push(SuggestedScreen.route);
          },
        ),

        const SizedBox(height: 16),
        Column(
          children: [
            for (int i = 0; i < entries.length; i++) ...[
              _WalletHistoryTile(entry: entries[i]),
              if (i != entries.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ],
    );
  }
}

class _WalletHistoryEntry {
  const _WalletHistoryEntry({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.amount,
  });

  final String title;
  final String subtitle;
  final String date;
  final String time;
  final int amount;
}

class _WalletHistoryTile extends StatelessWidget {
  const _WalletHistoryTile({required this.entry});

  final _WalletHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    final String formattedAmount = '${entry.amount >= 0 ? '+' : '-'} ${entry.amount.abs()} ${l10n.egp}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Co.w100,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Co.secondary,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              Assets.wallet,
              colorFilter: const ColorFilter.mode(Co.white, BlendMode.srcIn),
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title, style: TStyle.robotBlackMedium()),
                const SizedBox(height: 4),
                Text(entry.subtitle, style: TStyle.robotBlackRegular(font: FFamily.roboto)),
                const SizedBox(height: 4),
                Text(entry.date, style: TStyle.greyRegular(12, font: FFamily.roboto)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formattedAmount,
                style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple),
              ),
              const SizedBox(height: 4),
              Text(
                entry.time,
                style: TStyle.robotBlackMedium(font: FFamily.roboto).copyWith(color: Co.darkGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
