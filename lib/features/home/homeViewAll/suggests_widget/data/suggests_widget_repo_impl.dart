import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/data/dtos/suggests_widget_dto.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/domain/suggests_widget_repo.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestsWidgetRepoImpl extends SuggestsWidgetRepo {
  final ApiClient _apiClient;

  SuggestsWidgetRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<SuggestsWidgetData>> getSuggests() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.suggestsWidget),
      parser: (response) {
        // Save to cache in background
        _saveToCache(response.data);

        final dto = SuggestsWidgetDto.fromJson(response.data);
        if (dto.data == null) {
          return SuggestsWidgetData(entities: []);
        }
        final entities = dto.data!.entities.map((e) => e.toEntity()).whereType<GenericItemEntity>().toList();
        final banner = dto.data!.banner?.toEntity();
        return SuggestsWidgetData(entities: entities, banner: banner);
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.suggestsWidgetJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.suggestsWidgetTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<SuggestsWidgetData?> getCachedSuggests() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.suggestsWidgetJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = SuggestsWidgetDto.fromJson(map);
      if (dto.data == null) {
        return null;
      }
      final entities = dto.data!.entities.map((e) => e.toEntity()).whereType<GenericItemEntity>().toList();
      final banner = dto.data!.banner?.toEntity();
      return SuggestsWidgetData(entities: entities, banner: banner);
    } catch (e) {
      return null;
    }
  }
}
