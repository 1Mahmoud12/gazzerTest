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
