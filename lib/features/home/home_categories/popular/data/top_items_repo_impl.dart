import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/home_categories/popular/data/dtos/top_items_dto.dart';
import 'package:gazzer/features/home/home_categories/popular/domain/top_items_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kTopItemsJson = 'top_items_json';
const _kTopItemsTs = 'top_items_ts';

class TopItemsRepoImpl extends TopItemsRepo {
  final ApiClient _apiClient;

  TopItemsRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<TopItemsDtoData?>> getTopItems() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.topItems,
      ),
      parser: (response) {
        // Save to cache in background
        _saveToCache(response.data);

        final dto = TopItemsDto.fromJson(response.data);
        return dto.data;
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kTopItemsJson, jsonEncode(responseData));
      await sp.setInt(_kTopItemsTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<TopItemsDtoData?> getCachedTopItems() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(_kTopItemsJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = TopItemsDto.fromJson(map);
      return dto.data;
    } catch (e) {
      return null;
    }
  }
}
