import 'package:gazzer/features/loyaltyProgram/data/dto/loyalty_program_dto.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';

class WalletResponseDto {
  WalletResponseDto({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final WalletDataDto? data;

  factory WalletResponseDto.fromJson(Map<String, dynamic> json) {
    return WalletResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null ? null : WalletDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  WalletEntity? toEntity() => data?.toEntity();
}

class WalletDataDto {
  WalletDataDto({
    required this.wallet,
    required this.loyaltyPoints,
    required this.paymentCards,
    required this.recentTransactions,
    required this.availableVoucherAmounts,
  });

  final WalletInfoDto? wallet;
  final LoyaltyPointsDto? loyaltyPoints;
  final List<PaymentCardDto> paymentCards;
  final List<TransactionDto> recentTransactions;
  final List<VoucherAmountDto> availableVoucherAmounts;

  factory WalletDataDto.fromJson(Map<String, dynamic> json) {
    return WalletDataDto(
      wallet: json['wallet'] == null ? null : WalletInfoDto.fromJson(json['wallet'] as Map<String, dynamic>),
      loyaltyPoints: json['loyalty_points'] == null ? null : LoyaltyPointsDto.fromJson(json['loyalty_points'] as Map<String, dynamic>),
      paymentCards: (json['payment_cards'] as List<dynamic>?)?.map((e) => PaymentCardDto.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
      recentTransactions:
          (json['recent_transactions'] as List<dynamic>?)?.map((e) => TransactionDto.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
      availableVoucherAmounts:
          (json['available_voucher_amounts'] as List<dynamic>?)?.map((e) => VoucherAmountDto.fromJson(e as Map<String, dynamic>)).toList() ??
          const [],
    );
  }

  WalletEntity toEntity() => WalletEntity(
    wallet: wallet?.toEntity(),
    loyaltyPoints: loyaltyPoints?.toEntity(),
    paymentCards: paymentCards.map((e) => e.toEntity()).toList(),
    recentTransactions: recentTransactions.map((e) => e.toEntity()).toList(),
    availableVoucherAmounts: availableVoucherAmounts.map((e) => e.toEntity()).toList(),
  );
}

class WalletInfoDto {
  WalletInfoDto({
    required this.balance,
    required this.lastUpdated,
  });

  final num balance;
  final String lastUpdated;

  factory WalletInfoDto.fromJson(Map<String, dynamic> json) {
    return WalletInfoDto(
      balance: json['balance'] as num? ?? 0,
      lastUpdated: json['last_updated'] as String? ?? '',
    );
  }

  WalletInfoEntity toEntity() => WalletInfoEntity(
    balance: balance.toDouble(),
    lastUpdated: DateTime.tryParse(lastUpdated) ?? DateTime.now(),
  );
}

class LoyaltyPointsDto {
  LoyaltyPointsDto({
    required this.totalPoints,
    required this.availablePoints,
    required this.usedPoints,
    required this.conversionRate,
    required this.estimatedValue,
    required this.expiresAt,
    required this.pointsNearingExpiry,
    required this.expirationDetails,
  });

  final int totalPoints;
  final int availablePoints;
  final int usedPoints;
  final ConversionRateDto? conversionRate;
  final num estimatedValue;
  final String? expiresAt;
  final int pointsNearingExpiry;
  final List<ExpirationDetailDto> expirationDetails;

  factory LoyaltyPointsDto.fromJson(Map<String, dynamic> json) {
    return LoyaltyPointsDto(
      totalPoints: json['total_points'] as int? ?? 0,
      availablePoints: json['available_points'] as int? ?? 0,
      usedPoints: json['used_points'] as int? ?? 0,
      conversionRate: json['conversion_rate'] == null ? null : ConversionRateDto.fromJson(json['conversion_rate'] as Map<String, dynamic>),

      estimatedValue: json['estimated_value'] as num? ?? 0,
      expiresAt: json['expires_at'] as String?,
      pointsNearingExpiry: json['points_nearing_expiry'] as int? ?? 0,
      expirationDetails:
          (json['expiration_details'] as List<dynamic>?)?.map((e) => ExpirationDetailDto.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
    );
  }

  WalletLoyaltyPointsEntity toEntity() => WalletLoyaltyPointsEntity(
    totalPoints: totalPoints,
    availablePoints: availablePoints,
    usedPoints: usedPoints,
    conversionRate: conversionRate,
    estimatedValue: estimatedValue.toDouble(),
    expiresAt: expiresAt != null ? DateTime.tryParse(expiresAt!) : null,
    pointsNearingExpiry: pointsNearingExpiry,
    expirationDetails: expirationDetails.map((e) => e.toEntity()).toList(),
  );
}

class ExpirationDetailDto {
  ExpirationDetailDto({
    required this.expiresAt,
    required this.points,
  });

  final String expiresAt;
  final int points;

  factory ExpirationDetailDto.fromJson(Map<String, dynamic> json) {
    return ExpirationDetailDto(
      expiresAt: json['expires_at'] as String? ?? '',
      points: json['points'] as int? ?? 0,
    );
  }

  ExpirationDetailEntity toEntity() => ExpirationDetailEntity(
    expiresAt: DateTime.tryParse(expiresAt) ?? DateTime.now(),
    points: points,
  );
}

class PaymentCardDto {
  PaymentCardDto({
    required this.id,
    required this.last4Digits,
    required this.cardBrand,
    required this.cardholderName,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
  });

  final int id;
  final String last4Digits;
  final String cardBrand;
  final String? cardholderName;
  final int? expiryMonth;
  final int? expiryYear;
  final bool isDefault;

  factory PaymentCardDto.fromJson(Map<String, dynamic> json) {
    return PaymentCardDto(
      id: json['id'] as int? ?? 0,
      last4Digits: json['last_4_digits'] as String? ?? '',
      cardBrand: json['card_brand'] as String? ?? '',
      cardholderName: json['cardholder_name'] as String?,
      expiryMonth: json['expiry_month'] as int?,
      expiryYear: json['expiry_year'] as int?,
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  PaymentCardEntity toEntity() => PaymentCardEntity(
    id: id,
    last4Digits: last4Digits,
    cardBrand: cardBrand,
    cardholderName: cardholderName,
    expiryMonth: expiryMonth,
    expiryYear: expiryYear,
    isDefault: isDefault,
  );
}

class TransactionDto {
  TransactionDto({
    required this.id,
    required this.type,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.currency,
    required this.source,
    required this.note,
    required this.createdAt,
  });

  final int id;
  final String type;
  final num amount;
  final num balanceBefore;
  final num balanceAfter;
  final String currency;
  final String source;
  final String? note;
  final String createdAt;

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      amount: json['amount'] as num? ?? 0,
      balanceBefore: json['balance_before'] as num? ?? 0,
      balanceAfter: json['balance_after'] as num? ?? 0,
      currency: json['currency'] as String? ?? '',
      source: json['source'] as String? ?? '',
      note: json['note'] as String?,
      createdAt: json['created_at'] as String? ?? '',
    );
  }

  TransactionEntity toEntity() => TransactionEntity(
    id: id,
    type: type,
    amount: amount.toDouble(),
    currency: currency,
    source: source,
    note: note,
    createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
  );
}

class VoucherAmountDto {
  VoucherAmountDto({
    required this.amount,
    required this.pointsNeeded,
    required this.validUntil,
  });

  final int amount;
  final int pointsNeeded;
  final String validUntil;

  factory VoucherAmountDto.fromJson(Map<String, dynamic> json) {
    return VoucherAmountDto(
      amount: json['amount'] as int? ?? 0,
      pointsNeeded: json['points_needed'] as int? ?? 0,
      validUntil: json['valid_until'] as String? ?? '',
    );
  }

  VoucherAmountEntity toEntity() => VoucherAmountEntity(
    amount: amount,
    pointsNeeded: pointsNeeded,
    validUntil: validUntil,
  );
}
