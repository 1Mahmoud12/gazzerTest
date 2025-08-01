import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_details_response.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_menu_response.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_of_category_response.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';

class StoresRepoImp extends StoresRepo {
  final ApiClient _apiClient;

  StoresRepoImp(super.crashlyticsRepo, this._apiClient);

  @override
  Future<Result<StoresMenuResponse>> loadStoresMenuPage(int mainId) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.storesMenuPage(mainId)),
      parser: (response) => StoresMenuResponse.fromJson(response.data['data']),
    );
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
  Future<Result<ProductEntity>> loadProductDetails(int productId) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.productDetails(productId)),
      parser: (response) => ProductDTO.fromJson(response.data['data']).toProductItem(),
    );
  }
}
