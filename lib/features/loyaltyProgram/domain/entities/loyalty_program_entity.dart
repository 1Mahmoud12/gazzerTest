class LoyaltyProgramEntity {
  const LoyaltyProgramEntity({
    required this.currentTier,
    required this.tierProgress,
    required this.points,
    required this.tierBenefits,
  });

  final LoyaltyTier? currentTier;
  final TierProgress? tierProgress;
  final LoyaltyPoints? points;
  final List<TierBenefits> tierBenefits;
}

class LoyaltyTier {
  const LoyaltyTier({
    required this.name,
    required this.displayName,
    required this.icon,
    required this.color,
    required this.subtitle,
    required this.minOrderCount,
    required this.minProgress,
    required this.maxProgress,
  });

  final String? name;
  final String? displayName;
  final String? icon;
  final String? color;
  final String? subtitle;
  final int? minOrderCount;
  final num? minProgress;
  final num? maxProgress;
}

class TierProgress {
  const TierProgress({
    required this.currentTier,
    required this.totalSpent,
    required this.orderCount,
    required this.spentInLastDays,
    required this.daysPeriod,
    required this.nextTier,
    required this.progressPercentage,
  });

  final String? currentTier;
  final num? totalSpent;
  final num? orderCount;
  final num? spentInLastDays;
  final num? daysPeriod;
  final NextTier? nextTier;
  final num? progressPercentage;
}

class NextTier {
  const NextTier({
    required this.name,
    required this.displayName,
    required this.spentNeeded,
    required this.ordersNeeded,
  });

  final String? name;
  final String? displayName;
  final num? spentNeeded;
  final num? ordersNeeded;
}

class LoyaltyPoints {
  const LoyaltyPoints({
    required this.availablePoints,
    required this.totalPoints,
    required this.usedPoints,
    required this.earningRate,
    required this.conversionRate,
    required this.expiresAt,
    required this.pointsNearingExpiry,
  });

  final num? availablePoints;
  final num? totalPoints;
  final num? usedPoints;
  final EarningRate? earningRate;
  final ConversionRate? conversionRate;
  final DateTime? expiresAt;
  final num? pointsNearingExpiry;
}

class EarningRate {
  const EarningRate({required this.pointsPerAmount, required this.amountUnit});

  final num? pointsPerAmount;
  final num? amountUnit;
}

class ConversionRate {
  const ConversionRate({required this.points, required this.egp});

  final num? points;
  final num? egp;
}

class TierBenefits {
  const TierBenefits({required this.tier, required this.benefits});

  final LoyaltyTier? tier;
  final List<LoyaltyBenefit> benefits;
}

class LoyaltyBenefit {
  const LoyaltyBenefit({
    required this.id,
    required this.benefitType,
    required this.isEnabled,
    required this.title,
  });

  final int? id;
  final String? benefitType;
  final bool? isEnabled;
  final String? title;
}
