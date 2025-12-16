import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/data/dtos/daily_offers_widget_dto.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/domain/daily_offers_widget_repo.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyOffersWidgetRepoImpl extends DailyOffersWidgetRepo {
  final ApiClient _apiClient;

  DailyOffersWidgetRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<DailyOffersWidgetData>> getDailyOffers() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.dailyOffersWidget),
      parser: (response) {
        // Save to cache in background
        _saveToCache(response.data);

        final dto = DailyOffersWidgetDto.fromJson(response.data);
        if (dto.data == null) {
          return DailyOffersWidgetData(entities: []);
        }
        final entities = dto.data!.entities.map((e) => e.toEntity()).whereType<GenericItemEntity>().toList();
        final banner = dto.data!.banner?.toEntity();
        return DailyOffersWidgetData(entities: entities, banner: banner);
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.dailyOffersWidgetJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.dailyOffersWidgetTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<DailyOffersWidgetData?> getCachedDailyOffers() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.dailyOffersWidgetJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = DailyOffersWidgetDto.fromJson(map);
      if (dto.data == null) {
        return null;
      }
      final entities = dto.data!.entities.map((e) => e.toEntity()).whereType<GenericItemEntity>().toList();
      final banner = dto.data!.banner?.toEntity();
      return DailyOffersWidgetData(entities: entities, banner: banner);
    } catch (e) {
      return null;
    }
  }
}
