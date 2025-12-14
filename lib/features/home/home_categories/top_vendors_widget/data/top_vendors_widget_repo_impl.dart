import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/home_categories/top_vendors_widget/data/dtos/top_vendors_widget_dto.dart';
import 'package:gazzer/features/home/home_categories/top_vendors_widget/domain/top_vendors_widget_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopVendorsWidgetRepoImpl extends TopVendorsWidgetRepo {
  final ApiClient _apiClient;

  TopVendorsWidgetRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<TopVendorsWidgetData>> getTopVendors() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.topVendorsWidget),
      parser: (response) {
        // Save to cache in background
        _saveToCache(response.data);

        final dto = TopVendorsWidgetDto.fromJson(response.data);
        if (dto.data == null) {
          return TopVendorsWidgetData(vendors: []);
        }
        final vendors = dto.data!.toEntities();
        final banner = dto.data!.banner?.toEntity();
        return TopVendorsWidgetData(vendors: vendors, banner: banner);
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.topVendorsWidgetJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.topVendorsWidgetTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<TopVendorsWidgetData?> getCachedTopVendors() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.topVendorsWidgetJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = TopVendorsWidgetDto.fromJson(map);
      if (dto.data == null) {
        return null;
      }
      final vendors = dto.data!.toEntities();
      final banner = dto.data!.banner?.toEntity();
      return TopVendorsWidgetData(vendors: vendors, banner: banner);
    } catch (e) {
      return null;
    }
  }
}
