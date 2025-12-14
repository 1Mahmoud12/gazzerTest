import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/home_categories/top_items_widget/data/dtos/top_items_widget_dto.dart';
import 'package:gazzer/features/home/home_categories/top_items_widget/domain/top_items_widget_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopItemsWidgetRepoImpl extends TopItemsWidgetRepo {
  final ApiClient _apiClient;

  TopItemsWidgetRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<TopItemsWidgetData>> getTopItems() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.topItemsWidget),
      parser: (response) {
        _saveToCache(response.data);
        final dto = TopItemsWidgetDto.fromJson(response.data);
        if (dto.data == null) {
          return TopItemsWidgetData(entities: []);
        }
        final entities = dto.data!.toEntities();
        final banner = dto.data!.banner?.toEntity();
        return TopItemsWidgetData(entities: entities, banner: banner);
      },
    );
    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.topItemsWidgetJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.topItemsWidgetTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<TopItemsWidgetData?> getCachedTopItems() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.topItemsWidgetJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = TopItemsWidgetDto.fromJson(map);
      if (dto.data == null) {
        return null;
      }
      final entities = dto.data!.toEntities();
      final banner = dto.data!.banner?.toEntity();
      return TopItemsWidgetData(entities: entities, banner: banner);
    } catch (e) {
      return null;
    }
  }
}
