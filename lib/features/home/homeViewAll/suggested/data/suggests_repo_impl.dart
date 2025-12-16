import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/data/dtos/suggests_dto.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/domain/suggests_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kSuggestsJson = 'suggests_json';
const _kSuggestsTs = 'suggests_timestamp';

class SuggestsRepoImpl extends SuggestsRepo {
  final ApiClient _apiClient;

  SuggestsRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<SuggestsResponse>> getSuggests({int page = 1, int perPage = 10}) async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: '${Endpoints.suggests}?is_paginated=1&page=$page&per_page=$perPage'),
      parser: (response) {
        // Save to cache in background only for first page
        if (page == 1) {
          _saveToCache(response.data);
        }

        final dto = SuggestsDto.fromJson(response.data);
        return SuggestsResponse(data: dto.data, pagination: dto.pagination);
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kSuggestsJson, jsonEncode(responseData));
      await sp.setInt(_kSuggestsTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<SuggestsDtoData?> getCachedSuggests() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final jsonString = sp.getString(_kSuggestsJson);

      if (jsonString == null) return null;

      final jsonData = jsonDecode(jsonString);
      final dto = SuggestsDto.fromJson(jsonData);
      return dto.data;
    } catch (e) {
      return null;
    }
  }
}
