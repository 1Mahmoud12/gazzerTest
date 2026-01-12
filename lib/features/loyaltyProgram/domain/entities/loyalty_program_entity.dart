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


  factory LoyaltyProgramEntity.dummy() {
    return LoyaltyProgramEntity(
      currentTier: const LoyaltyTier(
        name: 'silver',
        displayName: 'Silver',
        icon: 'silver_badge.svg',
        color: '#C0C0C0',
        subtitle: 'Getting started',
        minOrderCount: 0,
        minProgress: 0,
        maxProgress: 1000,
      ),
      tierProgress: TierProgress(
        currentTier: 'silver',
        totalSpent: 750,
        orderCount: 7,
        spentInLastDays: 300,
        daysPeriod: 30,
        progressPercentage: 75,
        nextTier: const NextTier(
          name: 'gold',
          displayName: 'Gold',
          spentNeeded: 250,
          ordersNeeded: 3,
        ),
      ),
      points: LoyaltyPoints(
        availablePoints: 1200,
        totalPoints: 2000,
        usedPoints: 800,
        expiresAt: DateTime.now().add(const Duration(days: 60)),
        pointsNearingExpiry: 300,
        earningRate: const EarningRate(
          pointsPerAmount: 1,
          amountUnit: 1,
        ),
        conversionRate: const ConversionRate(
          points: 100,
          egp: 10,
        ),
      ),
      tierBenefits: [
        TierBenefits(
          tier: const LoyaltyTier(
            name: 'silver',
            displayName: 'Silver',
            icon: 'silver_badge.svg',
            color: '#C0C0C0',
            subtitle: 'Getting started',
            minOrderCount: 0,
            minProgress: 0,
            maxProgress: 1000,
          ),
          benefits: const [
            LoyaltyBenefit(
              id: 1,
              benefitType: 'free_delivery',
              isEnabled: true,
              title: 'Free Delivery',
            ),
          ],
        ),
        TierBenefits(
          tier: const LoyaltyTier(
            name: 'gold',
            displayName: 'Gold',
            icon: 'gold_badge.svg',
            color: '#FFD700',
            subtitle: 'More rewards',
            minOrderCount: 10,
            minProgress: 1000,
            maxProgress: 5000,
          ),
          benefits: const [
            LoyaltyBenefit(
              id: 1,
              benefitType: 'free_delivery',
              isEnabled: true,
              title: 'Free Delivery',
            ),
            LoyaltyBenefit(
              id: 2,
              benefitType: 'discount',
              isEnabled: true,
              title: 'Exclusive Discounts',
            ),
          ],
        ),
      ],
    );
  }



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
