import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/repos/categories_of_plates_repo.dart';
import 'package:gazzer/features/stores/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';

class RestaurantsMenuCubit extends Cubit<RestaurantsMenuStates> {
  final CategoriesOfPlatesRepo _catRepor;
  final RestaurantsRepo _platesReo;
  final _nonVendorIndeces = [0, 1, 2, 3, 6, 9, 12, 15];

  RestaurantsMenuCubit(this._catRepor, this._platesReo) : super(RestaurantsMenuInit());
  final cats = <(CategoryOfPlateEntity, bool)>[];

  Future<void> loadCategoriesOfPlates() async {
    emit(RestaurantsCategoriesLoading());
    cats.clear();
    final result = await _catRepor.getAllCategoriesOfPlates();
    switch (result) {
      case Ok<List<CategoryOfPlateEntity>> data:
        final defaultCat = CategoryOfPlateEntity(0, "", "", CategoryStyle.horizontalScrollHorzCard);
        for (var i = 0; i < data.value.length; i++) {
          if (_nonVendorIndeces.contains(i)) cats.add((defaultCat, true));
          cats.add((data.value[i], false));
        }
        emit(RestaurantsCategoriesLoaded(categories: cats));
        break;
      case Err<List<CategoryOfPlateEntity>> error:
        emit(RestaurantsCategoriesError(error.error.message));
    }
  }

  final plates = <RestaurantEntity>[];
  Future<void> loadPlates() async {
    emit(PlatesLoading());
    final result = await _platesReo.getAllRestaurants(1, 10);
    switch (result) {
      case Ok<List<RestaurantEntity>> data:
        plates.clear();
        plates.addAll(data.value);
        emit(PlatesLoaded(plates: data.value));
        break;
      case Err<List<RestaurantEntity>> error:
        emit(PlatesError(error.error.message));
    }
  }

  @override
  void emit(RestaurantsMenuStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
