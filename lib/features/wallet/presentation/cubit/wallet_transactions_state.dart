import 'package:equatable/equatable.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_transactions_entity.dart';

sealed class WalletTransactionsState extends Equatable {
  const WalletTransactionsState();

  @override
  List<Object?> get props => [];
}

class WalletTransactionsInitial extends WalletTransactionsState {
  const WalletTransactionsInitial();
}

class WalletTransactionsLoading extends WalletTransactionsState {
  const WalletTransactionsLoading({this.isInitial = false});

  final bool isInitial;

  @override
  List<Object?> get props => [isInitial];
}

class WalletTransactionsLoaded extends WalletTransactionsState {
  const WalletTransactionsLoaded({
    required this.transactions,
    required this.pagination,
    this.isCached = false,
  });

  final List<TransactionEntity> transactions;
  final PaginationEntity? pagination;
  final bool isCached;

  @override
  List<Object?> get props => [transactions, pagination, isCached];
}

class WalletTransactionsLoadingMore extends WalletTransactionsState {
  const WalletTransactionsLoadingMore({
    required this.transactions,
    required this.pagination,
  });

  final List<TransactionEntity> transactions;
  final PaginationEntity? pagination;

  @override
  List<Object?> get props => [transactions, pagination];
}

class WalletTransactionsError extends WalletTransactionsState {
  const WalletTransactionsError({
    required this.message,
    this.cachedTransactions,
    this.cachedPagination,
  });

  final String message;
  final List<TransactionEntity>? cachedTransactions;
  final PaginationEntity? cachedPagination;

  @override
  List<Object?> get props => [message, cachedTransactions, cachedPagination];
}
