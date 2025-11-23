import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/dto/faq_dto.dart';
import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';
import 'package:gazzer/features/supportScreen/domain/faq_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kFaqCategoriesJsonPrefix = 'faq_categories_json_';
const _kFaqCategoriesTsPrefix = 'faq_categories_ts_';

class FaqRepoImp extends FaqRepo {
  final ApiClient _apiClient;

  FaqRepoImp(this._apiClient, super.crashlyticsRepo);

  String _getCacheKey(String type) => '${_kFaqCategoriesJsonPrefix}$type';

  String _getTimestampKey(String type) => '${_kFaqCategoriesTsPrefix}$type';

  @override
  Future<Result<List<FaqCategoryEntity>>> getFaqCategories(String type) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.faqCategories,
        queryParameters: {'type': type},
      ),
      parser: (response) {
        // Save to cache in background
        _saveToCache(response.data, type);

        final categories = <FaqCategoryEntity>[];
        final data = response.data['data'] as List<dynamic>;
        for (var item in data) {
          categories.add(FaqCategoryDTO.fromJson(item as Map<String, dynamic>).toEntity());
        }
        return categories;
      },
    );
  }

  Future<void> _saveToCache(dynamic responseData, String type) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_getCacheKey(type), jsonEncode(responseData));
      await sp.setInt(_getTimestampKey(type), DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<List<FaqCategoryEntity>?> getCachedFaqCategories(String type) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(_getCacheKey(type));
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final data = map['data'] as List<dynamic>?;
      if (data == null) return null;

      final categories = <FaqCategoryEntity>[];
      for (var item in data) {
        categories.add(FaqCategoryDTO.fromJson(item as Map<String, dynamic>).toEntity());
      }
      return categories;
    } catch (e) {
      return null;
    }
  }
}
