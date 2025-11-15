import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
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

  Future<WalletTransactionsResponse?> getCachedWalletTransactions({String? type});
}
