import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';

sealed class RestaurantsMenuStates {}

final class RestaurantsMenuInit extends RestaurantsMenuStates {}



sealed class RestaurantsCategoriesStates extends RestaurantsMenuStates {
  final List<CategoryOfPlateEntity> categories;
  RestaurantsCategoriesStates({this.categories = const []});
}

final class RestaurantsCategoriesLoading extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoading() : super(categories: Fakers.fakeSubCats);
}

final class RestaurantsCategoriesLoaded extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoaded({required super.categories});
}

final class RestaurantsCategoriesError extends RestaurantsCategoriesStates {
  final String error;
  RestaurantsCategoriesError(this.error);
}

sealed class PlatesStates extends RestaurantsMenuStates {
  final List<RestaurantEntity> plates;
  PlatesStates({this.plates = const []});
}

final class PlatesLoading extends PlatesStates {
  PlatesLoading() : super(plates: Fakers().restaurants);
}

final class PlatesLoaded extends PlatesStates {
  PlatesLoaded({required super.plates});
}

final class PlatesError extends PlatesStates {
  final String error;
  PlatesError(this.error);
}
