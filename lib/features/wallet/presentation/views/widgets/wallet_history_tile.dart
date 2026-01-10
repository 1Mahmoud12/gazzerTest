import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class WalletHistoryEntry {
  const WalletHistoryEntry({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.amount,
    this.iconAsset = Assets.wallet,
  });

  final String title;
  final String subtitle;
  final String date;
  final String time;
  final int amount;
  final String iconAsset;
}

class WalletHistoryTile extends StatelessWidget {
  const WalletHistoryTile({super.key, required this.entry});

  final WalletHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
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
              entry.iconAsset,
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
                Text(entry.title, style: context.style16500),
                const SizedBox(height: 4),
                if (entry.subtitle.isNotEmpty &&
                    entry.subtitle != 'description')
                  Text(entry.subtitle, style: context.style16400),
                if (entry.subtitle.isNotEmpty &&
                    entry.subtitle != 'description')
                  const SizedBox(height: 4),
                Text(
                  entry.date,
                  style: context.style12400.copyWith(color: Co.darkGrey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(entry.amount < 0 || entry.title == L10n.tr().paid) ? '-' : '+'} ${entry.amount.abs()} ${L10n.tr().egp}',
                style: context.style20500.copyWith(color: Co.purple),
              ),
              const SizedBox(height: 4),
              Text(
                entry.time,
                style: context.style16500.copyWith(color: Co.darkGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
