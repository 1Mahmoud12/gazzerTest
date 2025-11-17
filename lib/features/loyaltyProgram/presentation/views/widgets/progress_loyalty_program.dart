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
    this.nameNextTier,
    this.progressNextTier,
  });

  final num spentPoints;
  final int spendDuration;
  final num totalPoints;
  final num maxProgramPoints;
  final Color mainColor;
  final double progress;
  final String? nameNextTier;
  final double? progressNextTier;

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
            L10n.tr().loyaltySpendSummary(
              Helpers.getProperPrice(spentPoints),
              spendDuration,
            ),
            style: TStyle.blackRegular(16, font: FFamily.roboto).copyWith(color: Co.darkGrey),
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
                Helpers.getProperPrice(maxProgramPoints),
                style: TStyle.burbleSemi(16, font: FFamily.roboto),
              ),
              Text(
                Helpers.getProperPrice(totalPoints),
                style: TStyle.burbleSemi(16, font: FFamily.roboto),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            L10n.tr().nextTier(
              nameNextTier ?? '',
              Helpers.getProperPrice((progressNextTier ?? 0).toInt()),
            ),
            style: TStyle.blackRegular(16, font: FFamily.roboto).copyWith(color: Co.darkGrey),
          ),
        ],
      ),
    );
  }
}
