import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';

abstract class RestaurantsRepo extends BaseApiRepo {
  RestaurantsRepo(super.crashlyticsRepo);

  /// ** restaurants
  Future<Result<List<RestaurantEntity>>> getAllRestaurants(int pag, int limit);
  Future<Result<List<RestaurantEntity>>> getRestaurantsByCatOfPlate(int catOfPlateId, {int pag = 0, int limit = 10});

  Future<Result<List<CategoryOfPlateEntity>>> getAllPlatesCategories();

  Future<Result<List<CategoryOfPlateEntity>>> getCategoriesOfPlatesByRestaurant(int restaurantId);
}
