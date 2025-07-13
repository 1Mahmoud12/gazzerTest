import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/data/dtos/restaurant_dto.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/repos/restaurants_repo.dart';

class RestaurantsRepoImp extends RestaurantsRepo {
  final ApiClient _apiClient;
  RestaurantsRepoImp(this._apiClient);

  @override
  Future<Result<List<RestaurantEntity>>> getAllRestaurants(int page, int limit) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.allRestaurants(page, limit)),
      parser: (response) {
        final data = <RestaurantEntity>[];
        for (var item in response.data['data']) {
          data.add(RestaurantDTO.fromJson(item).toRestEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<RestaurantEntity>>> getRestaurantsByCatOfPlate(int catOfPlateId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.retaurantsByCatOfPlate(catOfPlateId)),
      parser: (response) {
        final data = <RestaurantEntity>[];
        for (var item in response.data['data']) {
          data.add(RestaurantDTO.fromJson(item).toRestEntity());
        }
        return data;
      },
    );
  }
}
