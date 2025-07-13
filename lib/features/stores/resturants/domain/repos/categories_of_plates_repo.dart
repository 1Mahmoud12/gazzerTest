import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';

abstract class CategoriesOfPlatesRepo extends BaseApiRepo {
  Future<Result<List<CategoryOfPlateEntity>>> getAllCategoriesOfPlates();

  Future<Result<List<CategoryOfPlateEntity>>> getCategoriesOfPlatesByRestaurant(int restaurantId);
}
