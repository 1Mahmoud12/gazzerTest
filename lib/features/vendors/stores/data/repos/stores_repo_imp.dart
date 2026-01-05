import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_details_response.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_details_response.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_menu_response.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_of_category_response.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoresRepoImp extends StoresRepo {
  final ApiClient _apiClient;

  StoresRepoImp(super.crashlyticsRepo, this._apiClient);

  @override
  Future<Result<StoresMenuResponse>> loadStoresMenuPage(int mainId) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.storesMenuPage(mainId)),
      parser: (response) {
        // Save to cache in background
        _saveToCache(mainId, response.data['data']);
        return StoresMenuResponse.fromJson(response.data['data']);
      },
    );
  }

  Future<void> _saveToCache(int mainId, dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.storesMenuJson(mainId), jsonEncode(responseData));
      await sp.setInt(CacheKeys.storesMenuTs(mainId), DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<StoresMenuResponse?> getCachedStoresMenuPage(int mainId) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.storesMenuJson(mainId));
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      return StoresMenuResponse.fromJson(map);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Result<StoresOfCategoryResponse>> loadStoresOfCategoryPage(int mainId, int subId) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.storesOfSpecificCategoryPage(mainId, subId)),
      parser: (response) => StoresOfCategoryResponse.fromJson(response.data['data']),
    );
  }

  @override
  Future<Result<StoreDetailsResponse>> loadStoreDetails(int storeId) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.storeDetailsPage(storeId)),
      parser: (response) => StoreDetailsResponse.fromJson(response.data['data']),
    );
  }

  @override
  Future<Result<ProductDetailsResponse>> loadProductDetails(int productId) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.productDetails(productId)),
      parser: (response) => ProductDetailsResponse.fromJson(response.data['data']),
    );
  }
}
