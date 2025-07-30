import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_page_response.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurants_menu_page_reponse.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurants_of_categoryy_page_response.dart';

abstract class RestaurantsRepo extends BaseApiRepo {
  RestaurantsRepo(super.crashlyticsRepo);

  /// ** restaurants
  Future<Result<List<RestaurantEntity>>> getAllRestaurants(int pag, int limit);
  Future<Result<List<RestaurantEntity>>> getRestaurantsOfCategory(int catOfPlateId, {int pag = 0, int limit = 10});

  /// categories of plates
  Future<Result<List<CategoryOfPlateEntity>>> getAllPlatesCategories();
  Future<Result<List<CategoryOfPlateEntity>>> getCategoriesOfPlatesByRestaurant(int restaurantId);

  // ** sections
  Future<Result<List<RestaurantEntity>>> getTopRatedRestaurants(int id, {int pag = 0, int limit = 10});
  Future<Result<List<RestaurantEntity>>> getOffersRestaurants(int id, {int pag = 0, int limit = 10});
  Future<Result<List<RestaurantEntity>>> getTodaysPickRestaurants(int id, {int pag = 0, int limit = 10});

  /// pages
  Future<Result<RestaurantsMenuReponse>> loadRestaurantsMenuPage();

  Future<Result<RestaurantsOfCategoryyResponse>> loadRestaurantsOfCategoryPage(int id);

  Future<Result<RestaurantPageResponse>> loadRestaurantPage(int id);

  Future<Result<List<PlateEntity>>> getPlatesOfSpecificRestaurantCategory(int restId, int catId);
}
