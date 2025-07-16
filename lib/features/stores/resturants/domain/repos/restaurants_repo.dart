import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';

abstract class RestaurantsRepo extends BaseApiRepo {
  RestaurantsRepo(super.crashlyticsRepo);

  /// ** restaurants
  Future<Result<List<RestaurantEntity>>> getAllRestaurants(int pag, int limit);
  Future<Result<List<RestaurantEntity>>> getRestaurantsByCatOfPlate(int catOfPlateId);
}
