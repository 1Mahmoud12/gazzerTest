import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/data/category_of_plate_dto.dart';
import 'package:gazzer/features/stores/resturants/data/restaurant_dto.dart';
import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/restaurant_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/restaurant_repo.dart';

class RestaurantRepoImp extends RestaurantRepo {
  final ApiClient _apiClient;

  RestaurantRepoImp(this._apiClient);

  @override
  Future<Result<List<CategoryOfPlateEntity>>> getCategoriesOfPlates(int id) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.subcategory(id)),
      parser: (response) {
        final cats = <CategoryOfPlateEntity>[];
        for (final item in response.data['data']) {
          cats.add(CategoryOfPlateDTO.fromJson(item).toSubCategoryEntity());
        }
        return cats;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getRestaurantsByCat(int catId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.retaurantsByCat(catId)),
      parser: (response) {
        final rest = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          rest.add(RestaurantDTO.fromJson(item).toStorEntity());
        }
        return rest;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getRestaurantsBySubCat(int subCatId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.retaurantsBySubCat(subCatId)),
      parser: (response) {
        final rest = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          rest.add(RestaurantDTO.fromJson(item).toStorEntity());
        }
        return rest;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getRestaurantsByCatAnSubCat(int catId, int subCatId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.retaurantsByCatAnSubCat(catId, subCatId)),
      parser: (response) {
        final rest = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          rest.add(RestaurantDTO.fromJson(item).toStorEntity());
        }
        return rest;
      },
    );
  }
}
