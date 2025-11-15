import 'package:equatable/equatable.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading({this.isInitial = false});

  final bool isInitial;

  @override
  List<Object?> get props => [isInitial];
}

class WalletLoaded extends WalletState {
  const WalletLoaded({
    required this.data,
    this.isCached = false,
  });

  final WalletEntity data;
  final bool isCached;

  @override
  List<Object?> get props => [data, isCached];
}

class WalletError extends WalletState {
  const WalletError({
    required this.message,
    this.cachedData,
  });

  final String message;
  final WalletEntity? cachedData;

  @override
  List<Object?> get props => [message, cachedData];
}
