import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/domain/repos/banner_repo.dart';

class BannerRepoImp extends BannerRepo {
  final ApiClient _apiClient;
  BannerRepoImp(this._apiClient, super.crashlyticsRepo);
  @override
  Future<Result<List<BannerEntity>>> getRestaurantPageBanners() async {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.restaurantsMenuBanners),
      parser: (response) {
        return (response.data['data'] as List<dynamic>).map((e) => BannerDTO.fromJson(e).toEntity()).toList();
      },
    );
  }

  @override
  Future<Result<List<BannerEntity>>> getStoreCategoryBanners(int cateId) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.storeCategoryBanners(cateId)),
      parser: (response) {
        return (response.data['data'] as List<dynamic>).map((e) => BannerDTO.fromJson(e).toEntity()).toList();
      },
    );
  }
}
