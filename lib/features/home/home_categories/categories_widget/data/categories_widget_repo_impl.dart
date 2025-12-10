import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/home_categories/categories_widget/data/dtos/categories_widget_dto.dart';
import 'package:gazzer/features/home/home_categories/categories_widget/domain/categories_widget_repo.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesWidgetRepoImpl extends CategoriesWidgetRepo {
  final ApiClient _apiClient;

  CategoriesWidgetRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<MainCategoryEntity>>> getCategories() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.categoriesWidget),
      parser: (response) {
        // Save to cache in background
        _saveToCache(response.data);

        final dto = CategoriesWidgetDto.fromJson(response.data);
        return dto.data?.toEntities() ?? [];
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.categoriesWidgetJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.categoriesWidgetTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<List<MainCategoryEntity>?> getCachedCategories() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.categoriesWidgetJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = CategoriesWidgetDto.fromJson(map);
      return dto.data?.toEntities();
    } catch (e) {
      return null;
    }
  }
}
