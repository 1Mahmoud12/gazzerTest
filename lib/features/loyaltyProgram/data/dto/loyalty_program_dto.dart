import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';

class LoyaltyProgramResponseDto {
  LoyaltyProgramResponseDto({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final LoyaltyProgramDataDto? data;

  factory LoyaltyProgramResponseDto.fromJson(Map<String, dynamic> json) {
    return LoyaltyProgramResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null ? null : LoyaltyProgramDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  LoyaltyProgramEntity? toEntity() => data?.toEntity();
}

class LoyaltyProgramDataDto {
  LoyaltyProgramDataDto({
    required this.currentTier,
    required this.tierProgress,
    required this.points,
    required this.tierBenefits,
  });

  final LoyaltyTierDto? currentTier;
  final TierProgressDto? tierProgress;
  final LoyaltyPointsDto? points;
  final List<TierBenefitsDto> tierBenefits;

  factory LoyaltyProgramDataDto.fromJson(Map<String, dynamic> json) {
    return LoyaltyProgramDataDto(
      currentTier: json['current_tier'] == null ? null : LoyaltyTierDto.fromJson(json['current_tier'] as Map<String, dynamic>),
      tierProgress: json['tier_progress'] == null ? null : TierProgressDto.fromJson(json['tier_progress'] as Map<String, dynamic>),
      points: json['points'] == null ? null : LoyaltyPointsDto.fromJson(json['points'] as Map<String, dynamic>),
      tierBenefits: (json['tier_benefits'] as List<dynamic>?)?.map((e) => TierBenefitsDto.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
    );
  }

  LoyaltyProgramEntity toEntity() => LoyaltyProgramEntity(
    currentTier: currentTier?.toEntity(),
    tierProgress: tierProgress?.toEntity(),
    points: points?.toEntity(),
    tierBenefits: tierBenefits.map((e) => e.toEntity()).toList(),
  );
}

class LoyaltyTierDto {
  LoyaltyTierDto({
    required this.name,
    required this.displayName,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

  final String? name;
  final String? displayName;
  final String? icon;
  final String? color;
  final String? subtitle;

  factory LoyaltyTierDto.fromJson(Map<String, dynamic> json) {
    return LoyaltyTierDto(
      name: json['name'] as String?,
      displayName: json['display_name'] as String?,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      subtitle: json['subtitle'] as String?,
    );
  }

  LoyaltyTier toEntity() => LoyaltyTier(
    name: name,
    displayName: displayName,
    icon: icon,
    color: color,
    subtitle: subtitle,
  );
}

class TierProgressDto {
  TierProgressDto({
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
  final NextTierDto? nextTier;
  final num? progressPercentage;

  factory TierProgressDto.fromJson(Map<String, dynamic> json) {
    return TierProgressDto(
      currentTier: json['current_tier'] as String?,
      totalSpent: json['total_spent'],
      orderCount: json['order_count'],
      spentInLastDays: json['spent_in_last_days'],
      daysPeriod: json['days_period'],
      nextTier: json['next_tier'] == null ? null : NextTierDto.fromJson(json['next_tier'] as Map<String, dynamic>),
      progressPercentage: json['progress_percentage'],
    );
  }

  TierProgress toEntity() => TierProgress(
    currentTier: currentTier,
    totalSpent: totalSpent,
    orderCount: orderCount,
    spentInLastDays: spentInLastDays,
    daysPeriod: daysPeriod,
    nextTier: nextTier?.toEntity(),
    progressPercentage: progressPercentage,
  );
}

class NextTierDto {
  NextTierDto({
    required this.name,
    required this.displayName,
    required this.spentNeeded,
    required this.ordersNeeded,
  });

  final String? name;
  final String? displayName;
  final num? spentNeeded;
  final num? ordersNeeded;

  factory NextTierDto.fromJson(Map<String, dynamic> json) {
    return NextTierDto(
      name: json['name'] as String?,
      displayName: json['display_name'] as String?,
      spentNeeded: json['spent_needed'],
      ordersNeeded: json['orders_needed'],
    );
  }

  NextTier toEntity() => NextTier(
    name: name,
    displayName: displayName,
    spentNeeded: spentNeeded,
    ordersNeeded: ordersNeeded,
  );
}

class LoyaltyPointsDto {
  LoyaltyPointsDto({
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
  final EarningRateDto? earningRate;
  final ConversionRateDto? conversionRate;
  final DateTime? expiresAt;
  final num? pointsNearingExpiry;

  factory LoyaltyPointsDto.fromJson(Map<String, dynamic> json) {
    return LoyaltyPointsDto(
      availablePoints: json['available_points'],
      totalPoints: json['total_points'],
      usedPoints: json['used_points'],
      earningRate: json['earning_rate'] == null ? null : EarningRateDto.fromJson(json['earning_rate'] as Map<String, dynamic>),
      conversionRate: json['conversion_rate'] == null ? null : ConversionRateDto.fromJson(json['conversion_rate'] as Map<String, dynamic>),
      expiresAt: DateTime.tryParse(json['expires_at'] ?? ''),
      pointsNearingExpiry: json['points_nearing_expiry'],
    );
  }

  LoyaltyPoints toEntity() => LoyaltyPoints(
    availablePoints: availablePoints,
    totalPoints: totalPoints,
    usedPoints: usedPoints,
    earningRate: earningRate?.toEntity(),
    conversionRate: conversionRate?.toEntity(),
    expiresAt: expiresAt,
    pointsNearingExpiry: pointsNearingExpiry,
  );
}

class EarningRateDto {
  EarningRateDto({
    required this.pointsPerAmount,
    required this.amountUnit,
  });

  final num? pointsPerAmount;
  final num? amountUnit;

  factory EarningRateDto.fromJson(Map<String, dynamic> json) {
    return EarningRateDto(
      pointsPerAmount: json['points_per_amount'],
      amountUnit: json['amount_unit'],
    );
  }

  EarningRate toEntity() => EarningRate(
    pointsPerAmount: pointsPerAmount,
    amountUnit: amountUnit,
  );
}

class ConversionRateDto {
  ConversionRateDto({
    required this.points,
    required this.egp,
  });

  final num? points;
  final num? egp;

  factory ConversionRateDto.fromJson(Map<String, dynamic> json) {
    return ConversionRateDto(
      points: json['points'],
      egp: json['egp'],
    );
  }

  ConversionRate toEntity() => ConversionRate(
    points: points,
    egp: egp,
  );
}

class TierBenefitsDto {
  TierBenefitsDto({
    required this.tier,
    required this.benefits,
  });

  final LoyaltyTierDto? tier;
  final List<LoyaltyBenefitDto> benefits;

  factory TierBenefitsDto.fromJson(Map<String, dynamic> json) {
    return TierBenefitsDto(
      tier: json['tier'] == null ? null : LoyaltyTierDto.fromJson(json['tier'] as Map<String, dynamic>),
      benefits: (json['benefits'] as List<dynamic>?)?.map((e) => LoyaltyBenefitDto.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
    );
  }

  TierBenefits toEntity() => TierBenefits(
    tier: tier?.toEntity(),
    benefits: benefits.map((e) => e.toEntity()).toList(),
  );
}

class LoyaltyBenefitDto {
  LoyaltyBenefitDto({
    required this.id,
    required this.benefitType,
    required this.isEnabled,
    required this.title,
  });

  final int? id;
  final String? benefitType;
  final bool? isEnabled;
  final String? title;

  factory LoyaltyBenefitDto.fromJson(Map<String, dynamic> json) {
    return LoyaltyBenefitDto(
      id: json['id'] as int?,
      benefitType: json['benefit_type'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      title: json['title'] as String?,
    );
  }

  LoyaltyBenefit toEntity() => LoyaltyBenefit(
    id: id,
    benefitType: benefitType,
    isEnabled: isEnabled,
    title: title,
  );
}
