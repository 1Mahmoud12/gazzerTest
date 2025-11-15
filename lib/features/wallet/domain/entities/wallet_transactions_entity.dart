import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';

class WalletTransactionsResponse {
  const WalletTransactionsResponse({
    required this.pagination,
    required this.transactions,
  });

  final PaginationEntity? pagination;
  final List<TransactionEntity> transactions;
}

class PaginationEntity {
  const PaginationEntity({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  bool get hasMorePages => currentPage < lastPage;
}
