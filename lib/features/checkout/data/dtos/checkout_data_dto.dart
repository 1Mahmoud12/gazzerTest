import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';

class CheckoutDataDTO {
  final WalletDTO wallet;
  final LoyaltyPointsDTO loyaltyPoints;
  final List<PaymentCardDTO> paymentCards;

  CheckoutDataDTO({
    required this.wallet,
    required this.loyaltyPoints,
    required this.paymentCards,
  });

  factory CheckoutDataDTO.fromJson(Map<String, dynamic> json) {
    return CheckoutDataDTO(
      wallet: WalletDTO.fromJson(json['wallet'] ?? {}),
      loyaltyPoints: LoyaltyPointsDTO.fromJson(json['loyalty_points'] ?? {}),
      paymentCards: (json['payment_cards'] as List<dynamic>?)?.map((card) => PaymentCardDTO.fromJson(card)).toList() ?? [],
    );
  }
}

class WalletDTO {
  final double balance;

  WalletDTO({
    required this.balance,
  });

  factory WalletDTO.fromJson(Map<String, dynamic> json) {
    return WalletDTO(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class LoyaltyPointsDTO {
  final int totalPoints;
  final int availablePoints;
  final int usedPoints;
  final int conversionRate;
  final double estimatedValue;

  LoyaltyPointsDTO({
    required this.totalPoints,
    required this.availablePoints,
    required this.usedPoints,
    required this.conversionRate,
    required this.estimatedValue,
  });

  factory LoyaltyPointsDTO.fromJson(Map<String, dynamic> json) {
    return LoyaltyPointsDTO(
      totalPoints: (json['total_points'] as num?)?.toInt() ?? 0,
      availablePoints: (json['available_points'] as num?)?.toInt() ?? 0,
      usedPoints: (json['used_points'] as num?)?.toInt() ?? 0,
      conversionRate: (json['conversion_rate'] as num?)?.toInt() ?? 100,
      estimatedValue: (json['estimated_value'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class PaymentCardDTO {
  final int id;
  final String last4Digits;
  final String cardBrand;
  final String cardholderName;
  final String expiryMonth;
  final String expiryYear;
  final bool isDefault;

  PaymentCardDTO({
    required this.id,
    required this.last4Digits,
    required this.cardBrand,
    required this.cardholderName,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
  });

  factory PaymentCardDTO.fromJson(Map<String, dynamic> json) {
    return PaymentCardDTO(
      id: (json['id'] as num?)?.toInt() ?? 0,
      last4Digits: json['last_4_digits'] as String? ?? '',
      cardBrand: json['card_brand'] as String? ?? '',
      cardholderName: json['cardholder_name'] as String? ?? '',
      expiryMonth: json['expiry_month'] as String? ?? '',
      expiryYear: json['expiry_year'] as String? ?? '',
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  CardEntity toEntity() {
    int parsedYear = 0;
    if (expiryYear.isNotEmpty) {
      final yearStr = expiryYear.length >= 2 ? expiryYear.substring(expiryYear.length - 2) : expiryYear;
      parsedYear = int.tryParse(yearStr) ?? 0;
    }

    return CardEntity(
      id: id,
      cardNumber: '**** **** **** $last4Digits',
      expiryMonth: int.tryParse(expiryMonth) ?? 0,
      expiryYear: parsedYear,
      cardHolderName: cardholderName,
      isDefault: isDefault,
    );
  }
}

class VoucherDTO {
  final String code;
  final String discountType;
  final String discountValue; // keep as string to avoid precision issues

  VoucherDTO({
    required this.code,
    required this.discountType,
    required this.discountValue,
  });

  factory VoucherDTO.fromJson(Map<String, dynamic> json) {
    return VoucherDTO(
      code: json['code'] as String? ?? '',
      discountType: json['discount_type'] as String? ?? '',
      discountValue: json['discount_value']?.toString() ?? '0.00',
    );
  }
}
