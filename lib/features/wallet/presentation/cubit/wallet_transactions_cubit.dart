import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_transactions_entity.dart';
import 'package:gazzer/features/wallet/domain/wallet_repo.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_transactions_state.dart';

class WalletTransactionsCubit extends Cubit<WalletTransactionsState> {
  WalletTransactionsCubit(this._repo) : super(const WalletTransactionsInitial());

  final WalletRepo _repo;
  List<TransactionEntity> _transactions = [];
  PaginationEntity? _pagination;
  String? _currentType;
  int _currentPage = 1;
  static const int _perPage = 15;

  Future<void> load({bool forceRefresh = false, String? type}) async {
    _currentType = type;
    _currentPage = 1;

    if (!forceRefresh) {
      emit(const WalletTransactionsLoading(isInitial: true));
      final cached = await _repo.getCachedWalletTransactions(type: type);
      if (cached != null) {
        _transactions = cached.transactions;
        _pagination = cached.pagination;
        emit(
          WalletTransactionsLoaded(
            transactions: _transactions,
            pagination: _pagination,
            isCached: true,
          ),
        );
        if (!forceRefresh) {
          // Proceed to refresh data in background
        }
      }
    } else {
      emit(const WalletTransactionsLoading());
    }

    final result = await _repo.getWalletTransactions(
      page: _currentPage,
      perPage: _perPage,
      type: type,
    );

    switch (result) {
      case Ok<WalletTransactionsResponse>(:final value):
        _transactions = value.transactions;
        _pagination = value.pagination;
        _currentPage = value.pagination?.currentPage ?? 1;
        emit(
          WalletTransactionsLoaded(
            transactions: _transactions,
            pagination: _pagination,
            isCached: false,
          ),
        );
      case Err<WalletTransactionsResponse>(:final error):
        emit(
          WalletTransactionsError(
            message: error.message,
            cachedTransactions: _transactions.isNotEmpty ? _transactions : null,
            cachedPagination: _pagination,
          ),
        );
    }
  }

  Future<void> loadMore() async {
    if (_pagination == null || !_pagination!.hasMorePages) {
      return; // No more pages to load
    }

    emit(
      WalletTransactionsLoadingMore(
        transactions: _transactions,
        pagination: _pagination!,
      ),
    );

    final nextPage = _currentPage + 1;
    final result = await _repo.getWalletTransactions(
      page: nextPage,
      perPage: _perPage,
      type: _currentType,
    );

    switch (result) {
      case Ok<WalletTransactionsResponse>(:final value):
        _transactions.addAll(value.transactions);
        _pagination = value.pagination;
        _currentPage = value.pagination?.currentPage ?? nextPage;
        emit(
          WalletTransactionsLoaded(
            transactions: _transactions,
            pagination: _pagination,
            isCached: false,
          ),
        );
      case Err<WalletTransactionsResponse>(:final error):
        emit(
          WalletTransactionsError(
            message: error.message,
            cachedTransactions: _transactions,
            cachedPagination: _pagination,
          ),
        );
    }
  }

  Future<void> filterByType(String? type) async {
    await load(forceRefresh: true, type: type);
  }
}
