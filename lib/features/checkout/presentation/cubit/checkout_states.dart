import 'package:equatable/equatable.dart';

sealed class CheckoutStates extends Equatable {
  const CheckoutStates();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutStates {}

class VoucherLoading extends CheckoutStates {}

class VoucherChange extends CheckoutStates {
  const VoucherChange({required this.timestamp});

  final int timestamp;

  @override
  List<Object?> get props => [timestamp];
}

class VoucherLoaded extends CheckoutStates {
  const VoucherLoaded({
    required this.voucherCode,
  });

  final String? voucherCode;

  @override
  List<Object?> get props => [voucherCode];
}

class VoucherApplied extends CheckoutStates {
  const VoucherApplied({
    required this.voucherCode,
    required this.discountAmount,
  });

  final String voucherCode;
  final double discountAmount;

  @override
  List<Object?> get props => [voucherCode, discountAmount];
}

class VoucherError extends CheckoutStates {
  const VoucherError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

enum PaymentMethod {
  cashOnDelivery,
  creditDebitCard,
  gazzerWallet,
}

class PaymentMethodLoaded extends CheckoutStates {
  const PaymentMethodLoaded({
    required this.selectedPaymentMethod,
    this.walletBalance = 500.0,
  });

  final PaymentMethod selectedPaymentMethod;
  final double walletBalance;

  @override
  List<Object?> get props => [selectedPaymentMethod, walletBalance];
}

class CardEntity {
  const CardEntity({
    required this.id,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardHolderName,
    this.isDefault = false,
  });

  final String id;
  final String cardNumber;
  final int expiryMonth;
  final int expiryYear;
  final String cardHolderName;
  final bool isDefault;

  String get maskedCardNumber {
    if (cardNumber.length >= 4) {
      return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
    }
    return cardNumber;
  }

  String get formattedExpiry => '$expiryMonth / $expiryYear';
}

class CardsLoaded extends CheckoutStates {
  const CardsLoaded({required this.cards, required this.isCreating});

  final List<CardEntity> cards;
  final bool isCreating;

  @override
  List<Object?> get props => [cards, isCreating];
}

class CardCreated extends CheckoutStates {
  const CardCreated({required this.card});

  final CardEntity card;

  @override
  List<Object?> get props => [card];
}

class CardError extends CheckoutStates {
  const CardError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
