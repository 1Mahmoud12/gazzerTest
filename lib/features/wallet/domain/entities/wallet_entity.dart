import 'package:gazzer/features/loyaltyProgram/data/dto/loyalty_program_dto.dart';

class WalletEntity {
  const WalletEntity({
    required this.wallet,
    required this.loyaltyPoints,
    required this.paymentCards,
    required this.recentTransactions,
  });

  final WalletInfoEntity? wallet;
  final WalletLoyaltyPointsEntity? loyaltyPoints;
  final List<PaymentCardEntity> paymentCards;
  final List<TransactionEntity> recentTransactions;
}

class WalletInfoEntity {
  const WalletInfoEntity({
    required this.balance,
    required this.lastUpdated,
  });

  final double balance;
  final DateTime lastUpdated;
}

class WalletLoyaltyPointsEntity {
  const WalletLoyaltyPointsEntity({
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
  final double estimatedValue;
  final DateTime? expiresAt;
  final int pointsNearingExpiry;
  final List<ExpirationDetailEntity> expirationDetails;
}

class ExpirationDetailEntity {
  const ExpirationDetailEntity({
    required this.expiresAt,
    required this.points,
  });

  final DateTime expiresAt;
  final int points;
}

class PaymentCardEntity {
  const PaymentCardEntity({
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
}

class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.currency,
    required this.source,
    required this.note,
    required this.createdAt,
    this.metadata,
  });

  final int id;
  final String type;
  final double amount;
  final double balanceBefore;
  final double balanceAfter;
  final String currency;
  final String source;
  final String? note;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;
}
