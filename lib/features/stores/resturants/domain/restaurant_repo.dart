import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/restaurant_entity.dart';

abstract class RestaurantRepo extends BaseApiRepo {
  Future<Result<List<CategoryOfPlateEntity>>> getCategoriesOfPlates(int id);
  Future<Result<List<RestaurantEntity>>> getRestaurantsByCat(int catId);
  Future<Result<List<RestaurantEntity>>> getRestaurantsBySubCat(int subCatId);
  Future<Result<List<RestaurantEntity>>> getRestaurantsByCatAnSubCat(int catId, int subCatId);
}
