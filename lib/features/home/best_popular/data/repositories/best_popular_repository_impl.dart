import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/best_popular/data/dtos/best_popular_response_dto.dart';
import 'package:gazzer/features/home/best_popular/domain/repositories/best_popular_repository.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BestPopularRepositoryImpl extends BestPopularRepository {
  final ApiClient _apiClient;

  BestPopularRepositoryImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<BestPopularResponse>> getBestPopularStores({int page = 1, int perPage = 10}) async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: '${Endpoints.bestPopularStores}?is_paginated=1&page=$page&per_page=$perPage'),
      parser: (response) {
        // Save to cache in background only for first page
        if (page == 1) {
          _saveToCache(response.data);
        }

        final dto = BestPopularResponseDto.fromJson(response.data);
        final stores = dto.data.entities.map((e) => e.toEntity()).toList();
        return BestPopularResponse(stores: stores, pagination: dto.pagination);
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.bestPopularJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.bestPopularTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<List<StoreEntity>?> getCachedBestPopularStores() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.bestPopularJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = BestPopularResponseDto.fromJson(map);
      return dto.data.entities.map((e) => e.toEntity()).toList();
    } catch (e) {
      return null;
    }
  }
}
