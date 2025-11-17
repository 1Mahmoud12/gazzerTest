import 'package:equatable/equatable.dart';
import 'package:gazzer/features/wallet/domain/entities/voucher_store_entity.dart';

sealed class VoucherVendorsState extends Equatable {
  const VoucherVendorsState();

  @override
  List<Object?> get props => [];
}

class VoucherVendorsInitial extends VoucherVendorsState {
  const VoucherVendorsInitial();
}

class VoucherVendorsLoading extends VoucherVendorsState {
  const VoucherVendorsLoading();
}

class VoucherVendorsLoaded extends VoucherVendorsState {
  const VoucherVendorsLoaded({required this.stores});

  final List<VoucherStoreEntity> stores;

  @override
  List<Object?> get props => [stores];
}

class VoucherVendorsError extends VoucherVendorsState {
  const VoucherVendorsError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class VoucherVendorsConverting extends VoucherVendorsState {
  const VoucherVendorsConverting({required this.stores});

  final List<VoucherStoreEntity> stores;

  @override
  List<Object?> get props => [stores];
}

class VoucherVendorsConvertSuccess extends VoucherVendorsState {
  const VoucherVendorsConvertSuccess({
    required this.stores,
    required this.message,
  });

  final List<VoucherStoreEntity> stores;
  final String message;

  @override
  List<Object?> get props => [stores, message];
}

class VoucherVendorsConvertError extends VoucherVendorsState {
  const VoucherVendorsConvertError({
    required this.stores,
    required this.message,
  });

  final List<VoucherStoreEntity> stores;
  final String message;

  @override
  List<Object?> get props => [stores, message];
}
