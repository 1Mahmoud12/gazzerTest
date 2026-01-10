import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/category_of_plate_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_page_response.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurants_menu_page_reponse.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurants_of_categoryy_page_response.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';

class RestaurantsRepoImp extends RestaurantsRepo {
  final ApiClient _apiClient;
  RestaurantsRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<RestaurantEntity>>> getAllRestaurants(int page, int limit) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.allRestaurants(page, limit)),
      parser: (response) {
        final data = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          data.add(RestaurantDTO.fromJson(item).toRestEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getRestaurantsOfCategory(int catOfPlateId, {int pag = 0, int limit = 10}) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.retaurantsByCatOfPlate(catOfPlateId, pag: pag, limit: limit),
      ),
      parser: (response) {
        final data = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          data.add(RestaurantDTO.fromJson(item).toRestEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<CategoryOfPlateEntity>>> getAllPlatesCategories() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.platesCategories),
      parser: (response) {
        final data = <CategoryOfPlateEntity>[];
        for (final item in response.data['data']) {
          data.add(CategoryOfPlateDTO.fromJson(item).toCategoryOfPlateEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<CategoryOfPlateEntity>>> getCategoriesOfPlatesByRestaurant(int restaurantId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.categoryOfPlatesByRest(restaurantId)),
      parser: (response) {
        final data = <CategoryOfPlateEntity>[];
        for (final item in response.data['data']) {
          data.add(CategoryOfPlateDTO.fromJson(item).toCategoryOfPlateEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getOffersRestaurants(int id, {int pag = 0, int limit = 10}) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.offersRestaurants(id, pag: pag, limit: limit),
      ),
      parser: (response) {
        final data = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          data.add(RestaurantDTO.fromJson(item).toRestEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getTodaysPickRestaurants(int id, {int pag = 0, int limit = 10}) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.todaysPicRestaurants(id, pag: pag, limit: limit),
      ),
      parser: (response) {
        final data = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          data.add(RestaurantDTO.fromJson(item).toRestEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getTopRatedRestaurants(int id, {int pag = 0, int limit = 10}) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.topRatedRestaurants(id, pag: pag, limit: limit),
      ),
      parser: (response) {
        final data = <RestaurantEntity>[];
        for (final item in response.data['data']) {
          data.add(RestaurantDTO.fromJson(item).toRestEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<RestaurantsMenuReponse>> loadRestaurantsMenuPage() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.restaurantsMenuPage),
      parser: (response) {
        return RestaurantsMenuReponse.fromJson(response.data['data']);
      },
    );
  }

  @override
  Future<Result<RestaurantsOfCategoryyResponse>> loadRestaurantsOfCategoryPage(int id) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.restaurantsOfCategoryPage(id)),
      parser: (response) {
        return RestaurantsOfCategoryyResponse.fromJson(response.data['data']);
      },
    );
  }

  @override
  Future<Result<RestaurantPageResponse>> loadRestaurantPage(int id) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.restaurantPage(id)),
      parser: (response) {
        return RestaurantPageResponse.fromJson(response.data['data']);
      },
    );
  }

  @override
  Future<Result<List<PlateEntity>>> getPlatesOfSpecificRestaurantCategory(int restId, int catId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.platesOfRestaurantCategory(restId, catId)),
      parser: (response) {
        final plates = (response.data['data'] as List).map((e) => PlateDTO.fromJson(e).toEntity()).toList();
        plates.sort((a, b) => a.outOfStock ? 1 : -1);
        return plates;
      },
    );
  }
}
