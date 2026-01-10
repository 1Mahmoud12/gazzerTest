import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/wallet/domain/entities/add_balance_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/voucher_store_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_transactions_entity.dart';

abstract class WalletRepo extends BaseApiRepo {
  WalletRepo(super.crashlyticsRepo);

  Future<Result<WalletEntity?>> getWallet();

  Future<WalletEntity?> getCachedWallet();

  Future<Result<String>> convertPoints(int points);

  Future<Result<WalletTransactionsResponse>> getWalletTransactions({
    int page = 1,
    int perPage = 15,
    String? type,
  });

  Future<WalletTransactionsResponse?> getCachedWalletTransactions({
    String? type,
  });

  Future<Result<AddBalanceResponse?>> addBalance({
    required double amount,
    required String description,
    required String paymentMethod,
    String? phone,
    int? cardId,
  });

  Future<Result<List<VoucherStoreEntity>>> getVoucherStores(int amount);

  Future<Result<String>> convertVoucher(String voucherCode);
}
