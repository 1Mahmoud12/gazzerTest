import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/home_categories/best_popular_stores_widget/data/dtos/best_popular_stores_widget_dto.dart';
import 'package:gazzer/features/home/home_categories/best_popular_stores_widget/domain/best_popular_stores_widget_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BestPopularStoresWidgetRepoImpl extends BestPopularStoresWidgetRepo {
  final ApiClient _apiClient;

  BestPopularStoresWidgetRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<BestPopularStoresWidgetData>> getBestPopularStores() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.bestPopularStoresWidget),
      parser: (response) {
        // Save to cache in background
        _saveToCache(response.data);

        final dto = BestPopularStoresWidgetDto.fromJson(response.data);
        if (dto.data == null) {
          return BestPopularStoresWidgetData(stores: []);
        }
        final stores = dto.data!.toEntities();
        final banner = dto.data!.banner?.toEntity();
        return BestPopularStoresWidgetData(stores: stores, banner: banner);
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.bestPopularStoresWidgetJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.bestPopularStoresWidgetTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<BestPopularStoresWidgetData?> getCachedBestPopularStores() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.bestPopularStoresWidgetJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = BestPopularStoresWidgetDto.fromJson(map);
      if (dto.data == null) {
        return null;
      }
      final stores = dto.data!.toEntities();
      final banner = dto.data!.banner?.toEntity();
      return BestPopularStoresWidgetData(stores: stores, banner: banner);
    } catch (e) {
      return null;
    }
  }
}
