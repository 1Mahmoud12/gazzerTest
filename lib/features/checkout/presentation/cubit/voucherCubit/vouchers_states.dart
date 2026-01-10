import 'package:equatable/equatable.dart';

sealed class VouchersStates extends Equatable {
  const VouchersStates();

  @override
  List<Object?> get props => [];
}

class VouchersInitial extends VouchersStates {}

class VoucherLoading extends VouchersStates {}

class VoucherChange extends VouchersStates {
  const VoucherChange({required this.timestamp});

  final int timestamp;

  @override
  List<Object?> get props => [timestamp];
}

class VoucherApplied extends VouchersStates {
  const VoucherApplied({
    required this.voucherCode,
    required this.discountAmount,
    required this.discountType,
  });

  final String voucherCode;
  final double discountAmount;
  final String discountType; // 'fixed' | 'percentage'

  @override
  List<Object?> get props => [voucherCode, discountAmount, discountType];
}

class VoucherError extends VouchersStates {
  const VoucherError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
