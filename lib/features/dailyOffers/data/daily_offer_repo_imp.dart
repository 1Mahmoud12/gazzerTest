import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';
import 'package:gazzer/features/dailyOffers/domain/daily_offer_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kDailyOffersJson = 'daily_offers_json';
const _kDailyOffersTs = 'daily_offers_ts';

class DailyOfferRepoImp extends DailyOfferRepo {
  final ApiClient _apiClient;

  DailyOfferRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<DailyOfferDataModel?>> getAllDailyOffer({
    String? search,
  }) async {
    final result = await super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.getAllOffers,
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
        },
      ),
      parser: (response) {
        // Save to cache in background only if no search
        if (search == null || search.isEmpty) {
          _saveToCache(response.data);
        }

        final dto = DailyOffersDto.fromJson(response.data);
        return dto.data?.data;
      },
    );

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kDailyOffersJson, jsonEncode(responseData));
      await sp.setInt(_kDailyOffersTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<DailyOfferDataModel?> getCachedDailyOffer() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(_kDailyOffersJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = DailyOffersDto.fromJson(map);
      return dto.data?.data;
    } catch (e) {
      return null;
    }
  }
}
