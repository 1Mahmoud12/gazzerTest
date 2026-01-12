import 'package:gazzer/features/loyaltyProgram/data/dto/loyalty_program_dto.dart';

class WalletEntity {
  const WalletEntity({
    required this.wallet,
    required this.loyaltyPoints,
    required this.paymentCards,
    required this.recentTransactions,
    required this.availableVoucherAmounts,
  });

  final WalletInfoEntity? wallet;
  final WalletLoyaltyPointsEntity? loyaltyPoints;
  final List<PaymentCardEntity> paymentCards;
  final List<TransactionEntity> recentTransactions;
  final List<VoucherAmountEntity> availableVoucherAmounts;



  factory WalletEntity.dummy() {
    return WalletEntity(
      wallet: WalletInfoEntity(
        balance: 1250.75,
        lastUpdated: DateTime.now(),
      ),
      loyaltyPoints: WalletLoyaltyPointsEntity(
        totalPoints: 5000,
        availablePoints: 3200,
        usedPoints: 1800,
        conversionRateBerTransaction: 100,
        conversionRate:  ConversionRateDto(
          points: 100,
          egp: 10,
        ),
        estimatedValue: 320.0,
        expiresAt: DateTime.now().add(const Duration(days: 45)),
        pointsNearingExpiry: 600,
        expirationDetails: [
          ExpirationDetailEntity(
            expiresAt: DateTime.now().add(const Duration(days: 15)),
            points: 300,
          ),
          ExpirationDetailEntity(
            expiresAt: DateTime.now().add(const Duration(days: 45)),
            points: 300,
          ),
        ],
      ),
      paymentCards: const [
        PaymentCardEntity(
          id: 1,
          last4Digits: '4242',
          cardBrand: 'Visa',
          cardholderName: 'John Doe',
          expiryMonth: 12,
          expiryYear: 2027,
          isDefault: true,
        ),
        PaymentCardEntity(
          id: 2,
          last4Digits: '1881',
          cardBrand: 'Mastercard',
          cardholderName: 'John Doe',
          expiryMonth: 6,
          expiryYear: 2026,
          isDefault: false,
        ),
      ],
      recentTransactions: [
        TransactionEntity(
          id: 101,
          type: 'credit',
          amount: 250.0,
          currency: 'EGP',
          source: 'Order #5432',
          note: 'Cashback reward',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          metadata: const {'orderId': 5432},
        ),
        TransactionEntity(
          id: 102,
          type: 'debit',
          amount: -120.0,
          currency: 'EGP',
          source: 'Voucher Redemption',
          note: 'Used points',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          metadata: const {'voucherAmount': 100},
        ),
      ],
      availableVoucherAmounts: const [
        VoucherAmountEntity(
          amount: 50,
          pointsNeeded: 500,
          validUntil: '2026-01-31',
        ),
        VoucherAmountEntity(
          amount: 100,
          pointsNeeded: 900,
          validUntil: '2026-03-31',
        ),
        VoucherAmountEntity(
          amount: 200,
          pointsNeeded: 1700,
          validUntil: '2026-06-30',
        ),
      ],
    );
  }
}












class WalletInfoEntity {
  const WalletInfoEntity({required this.balance, required this.lastUpdated});

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
    required this.conversionRateBerTransaction,
  });

  final int totalPoints;
  final int availablePoints;
  final int usedPoints;
  final int conversionRateBerTransaction;
  final ConversionRateDto? conversionRate;
  final double estimatedValue;
  final DateTime? expiresAt;
  final int pointsNearingExpiry;
  final List<ExpirationDetailEntity> expirationDetails;
}

class ExpirationDetailEntity {
  const ExpirationDetailEntity({required this.expiresAt, required this.points});

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
    required this.currency,
    required this.source,
    required this.note,
    required this.createdAt,
    this.metadata,
  });

  final int id;
  final String type;
  final double amount;
  final String currency;
  final String source;
  final String? note;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;
}

class VoucherAmountEntity {
  const VoucherAmountEntity({
    required this.amount,
    required this.pointsNeeded,
    required this.validUntil,
  });

  final int amount;
  final int pointsNeeded;
  final String validUntil;
}
