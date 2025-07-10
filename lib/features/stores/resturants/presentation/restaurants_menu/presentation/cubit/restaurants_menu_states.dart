import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';

sealed class RestaurantsMenuStates {}

final class RestaurantsMenuInit extends RestaurantsMenuStates {}

sealed class RestaurantsCategoriesStates extends RestaurantsMenuStates {
  final List<CategoryOfPlateEntity> categories;
  RestaurantsCategoriesStates([this.categories = const []]);
}

final class RestaurantsCategoriesLoading extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoading() : super(Fakers.fakeSubCats);
}

final class RestaurantsCategoriesLoaded extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoaded(List<CategoryOfPlateEntity> categories);
}

final class RestaurantsCategoriesError extends RestaurantsCategoriesStates {
  final String error;

  RestaurantsCategoriesError(this.error);
}
