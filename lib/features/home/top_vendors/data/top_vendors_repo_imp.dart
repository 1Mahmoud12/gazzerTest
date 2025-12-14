import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/top_vendors/data/dtos/top_vendors_dto.dart';
import 'package:gazzer/features/home/top_vendors/domain/top_vendors_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopVendorsRepoImp extends TopVendorsRepo {
  final ApiClient _apiClient;

  TopVendorsRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<VendorEntity>>> getTopVendors() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.topVendors),
      parser: (response) {
        _saveToCache(response.data);
        final dto = TopVendorsDto.fromJson(response.data);
        return dto.data?.entities
                .map(
                  (vendor) => VendorEntity(
                    id: vendor.id ?? 0,
                    storeId: vendor.storeInfo?.storeId ?? 0,
                    name: vendor.vendorName ?? '',
                    contactPerson: vendor.contactPerson,
                    secondContactPerson: vendor.secondContactPerson,
                    image: vendor.image ?? '',
                    type: vendor.storeInfo?.storeCategoryType ?? '',
                  ),
                )
                .toList() ??
            [];
      },
    );
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(CacheKeys.topVendorsJson, jsonEncode(responseData));
      await sp.setInt(CacheKeys.topVendorsTs, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<List<VendorEntity>?> getCachedTopVendors() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(CacheKeys.topVendorsJson);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = TopVendorsDto.fromJson(map);
      if (dto.data == null) return null;

      return dto.data!.entities
          .map(
            (vendor) => VendorEntity(
              id: vendor.id ?? 0,
              storeId: vendor.storeInfo?.storeId ?? 0,
              name: vendor.vendorName ?? '',
              contactPerson: vendor.contactPerson,
              secondContactPerson: vendor.secondContactPerson,
              image: vendor.image ?? '',
              type: vendor.storeInfo?.storeCategoryType ?? '',
            ),
          )
          .toList();
    } catch (e) {
      return null;
    }
  }
}
