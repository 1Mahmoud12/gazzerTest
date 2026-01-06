import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';

class ProgressLoyaltyPrograms extends StatelessWidget {
  const ProgressLoyaltyPrograms({
    super.key,
    required this.spentPoints,
    required this.spendDuration,
    required this.totalPoints,
    required this.maxProgramPoints,
    required this.mainColor,
    required this.progress,
    required this.minOrderCount,
    required this.minProgress,
    required this.maxProgress,
    this.nameNextTier,
    this.nameCurrentTier,
    this.progressNextTier,
  });

  final num spentPoints;
  final int spendDuration;
  final int minOrderCount;
  final num totalPoints;
  final num maxProgramPoints;
  final num minProgress;
  final num maxProgress;
  final Color mainColor;
  final double progress;
  final String? nameNextTier;
  final String? nameCurrentTier;
  final double? progressNextTier;

  String _buildNextTierMessage(BuildContext context, String name, int count, num currency) {
    final hasCurrency = currency > 0;
    final hasCount = count > 0;
    final currencyStr = Helpers.getProperPrice(currency.toInt());
    final isArabic = L10n.isAr(context);

    if (!hasCurrency && !hasCount) {
      // Only show the tier name - reach the tier
      if (isArabic) {
        return 'لكي تصل الي المستوي $name';
      } else {
        return 'Reach $name tier';
      }
    }

    if (!hasCurrency) {
      // Only show count, no currency
      if (isArabic) {
        return 'اطلب $count طلب اكثر لكي تصل الي المستوي $name';
      } else {
        return '$count orders more to reach $name tier';
      }
    }

    if (!hasCount) {
      // Only show currency, no count
      if (isArabic) {
        return 'انفق $currencyStr لكي تصل الي المستوي $name';
      } else {
        return 'Spend $currencyStr to reach $name tier';
      }
    }

    // Both currency and count are present
    return L10n.tr().nextTier(name, count, currencyStr);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            L10n.tr().loyaltySpendSummary(Helpers.getProperPrice(spentPoints), spendDuration),
            style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            color: Co.secondary,
            backgroundColor: Co.w100,
            minHeight: 16,
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Helpers.getProperPrice(minProgress),
                style: TStyle.robotBlackRegular().copyWith(color: Co.purple, fontWeight: TStyle.semi),
              ),
              Text(
                Helpers.getProperPrice(maxProgress),
                style: TStyle.robotBlackRegular().copyWith(color: Co.purple, fontWeight: TStyle.semi),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            (nameCurrentTier == 'HERO')
                ? L10n.tr().reachForMaxTier
                : _buildNextTierMessage(context, nameNextTier ?? '', minOrderCount, progressNextTier ?? 0),
            style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
