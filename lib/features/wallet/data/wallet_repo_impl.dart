import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/wallet/data/dto/add_balance_response_dto.dart';
import 'package:gazzer/features/wallet/data/dto/voucher_store_dto.dart';
import 'package:gazzer/features/wallet/data/dto/wallet_dto.dart';
import 'package:gazzer/features/wallet/data/dto/wallet_transactions_dto.dart';
import 'package:gazzer/features/wallet/data/requests/add_balance_request.dart';
import 'package:gazzer/features/wallet/data/requests/convert_points_request.dart';
import 'package:gazzer/features/wallet/domain/entities/add_balance_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/voucher_store_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_transactions_entity.dart';
import 'package:gazzer/features/wallet/domain/wallet_repo.dart';
import 'package:gazzer/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kWalletCache = 'wallet_json';
const _kWalletTs = 'wallet_timestamp';
const _kWalletTransactionsCache = 'wallet_transactions_json';
const _kWalletTransactionsTs = 'wallet_transactions_timestamp';

class WalletRepoImpl extends WalletRepo {
  WalletRepoImpl(this._apiClient, super.crashlyticsRepo);

  final ApiClient _apiClient;

  @override
  Future<Result<WalletEntity?>> getWallet() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.wallet),
      parser: (response) {
        _saveToCache(response.data);
        final dto = WalletResponseDto.fromJson(response.data as Map<String, dynamic>);
        return dto.toEntity();
      },
    );

    if (result is Err<WalletEntity?>) {
      final cached = await getCachedWallet();
      if (cached != null) {
        return Result.ok(cached);
      }
    }

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kWalletCache, jsonEncode(responseData));
      await sp.setInt(_kWalletTs, DateTime.now().millisecondsSinceEpoch);
    } catch (_) {
      // ignore cache failures
    }
  }

  @override
  Future<WalletEntity?> getCachedWallet() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(_kWalletCache);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = WalletResponseDto.fromJson(map);
      return dto.toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<String>> convertPoints(int points) async {
    final request = ConvertPointsRequest(points: points);
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.convertPoints,
        requestBody: request.toJson(),
      ),
      parser: (response) {
        return response.data['message'] as String? ?? 'Points converted successfully';
      },
    );
  }

  @override
  Future<Result<WalletTransactionsResponse>> getWalletTransactions({
    int page = 1,
    int perPage = 15,
    String? type,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
    if (type != null && type.isNotEmpty) {
      queryParams['type'] = type;
    }

    final result = await super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.walletTransactions,
        queryParameters: queryParams,
      ),
      parser: (response) {
        _saveTransactionsToCache(response.data, type);
        final dto = WalletTransactionsResponseDto.fromJson(response.data as Map<String, dynamic>);
        return dto.toEntity();
      },
    );

    if (result is Err<WalletTransactionsResponse>) {
      final cached = await getCachedWalletTransactions(type: type);
      if (cached != null) {
        return Result.ok(cached);
      }
    }

    return result;
  }

  Future<void> _saveTransactionsToCache(dynamic responseData, String? type) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final cacheKey = type != null ? '${_kWalletTransactionsCache}_$type' : _kWalletTransactionsCache;
      await sp.setString(cacheKey, jsonEncode(responseData));
      await sp.setInt(_kWalletTransactionsTs, DateTime.now().millisecondsSinceEpoch);
    } catch (_) {
      // ignore cache failures
    }
  }

  @override
  Future<WalletTransactionsResponse?> getCachedWalletTransactions({String? type}) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final cacheKey = type != null ? '${_kWalletTransactionsCache}_$type' : _kWalletTransactionsCache;
      final raw = sp.getString(cacheKey);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = WalletTransactionsResponseDto.fromJson(map);
      return dto.toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<AddBalanceResponse?>> addBalance({
    required double amount,
    required String description,
    required String paymentMethod,
    String? phone,
    int? cardId,
  }) async {
    final request = AddBalanceRequest(
      amount: amount,
      description: description,
      paymentMethod: paymentMethod,
      phone: phone,
      cardId: cardId,
    );
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.addBalance,
        requestBody: request.toJson(),
      ),
      parser: (response) {
        logger.d(response.data);
        final dto = AddBalanceResponseDto.fromJson(response.data as Map<String, dynamic>);
        return AddBalanceResponse(
          walletTopUpId: dto.walletTopUpId,
          amount: dto.amount,
          paymentMethod: dto.paymentMethod,
          paymentStatus: dto.paymentStatus,
          iframeUrl: dto.iframeUrl,
        );
      },
    );
  }

  @override
  Future<Result<List<VoucherStoreEntity>>> getVoucherStores(int amount) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.voucherStores(amount)),
      parser: (response) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => VoucherStoreDto.fromJson(json as Map<String, dynamic>).toEntity()).toList();
      },
    );
  }

  @override
  Future<Result<String>> convertVoucher(String voucherCode) {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.convertVoucher,
        requestBody: {'voucher_code': voucherCode},
      ),
      parser: (response) {
        return response.data['message'] as String? ?? 'Voucher converted successfully';
      },
    );
  }
}
