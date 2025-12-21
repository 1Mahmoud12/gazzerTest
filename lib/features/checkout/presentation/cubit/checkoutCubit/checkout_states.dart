import 'package:equatable/equatable.dart';
import 'package:gazzer/features/checkout/data/dtos/order_summary_dto.dart';
import 'package:gazzer/features/profile/presentation/views/saved_cards_screen.dart';

sealed class CheckoutStates extends Equatable {
  const CheckoutStates();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutStates {}

class CheckoutDataLoading extends CheckoutStates {}

class CheckoutDataLoaded extends CheckoutStates {
  const CheckoutDataLoaded({required this.walletBalance, required this.availablePoints, required this.paymentCards});

  final double walletBalance;
  final int availablePoints;
  final List<CardEntity> paymentCards;

  @override
  List<Object?> get props => [walletBalance, availablePoints, paymentCards];
}

enum PaymentMethod { cashOnDelivery, creditDebitCard, wallet, gazzerWallet, applePay }

class PaymentMethodLoaded extends CheckoutStates {
  const PaymentMethodLoaded({required this.selectedPaymentMethod, this.walletBalance = 500.0, this.availablePoints = 0});

  final PaymentMethod selectedPaymentMethod;
  final double walletBalance;
  final int availablePoints;

  @override
  List<Object?> get props => [selectedPaymentMethod, walletBalance, availablePoints];
}

class InsufficientWalletBalance extends CheckoutStates {
  const InsufficientWalletBalance({required this.shortfall});

  final double shortfall;

  @override
  List<Object?> get props => [shortfall];
}

class CardEntity {
  const CardEntity({
    required this.id,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardHolderName,
    this.isDefault = false,
    this.cardBrand,
  });

  final int id;
  final String cardNumber;
  final int expiryMonth;
  final int expiryYear;
  final String cardHolderName;
  final CardBrand? cardBrand;
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

class CardChange extends CheckoutStates {
  const CardChange({required this.timestamp});

  final int timestamp;

  @override
  List<Object?> get props => [timestamp];
}

class OrderSummaryLoading extends CheckoutStates {}

class OrderSummaryLoaded extends CheckoutStates {
  const OrderSummaryLoaded({required this.orderSummary});

  final OrderSummaryDTO orderSummary;

  @override
  List<Object?> get props => [orderSummary];
}

class OrderSummaryError extends CheckoutStates {
  const OrderSummaryError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
