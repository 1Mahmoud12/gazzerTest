import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/restaurant_repo.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';

class RestaurantsMenuCubit extends Cubit<RestaurantsMenuStates> {
  final RestaurantRepo _repo;
  RestaurantsMenuCubit(this._repo) : super(RestaurantsMenuInit());

  Future<void> loadCategoriesOfPlates(int id) async {
    emit(RestaurantsCategoriesLoading());
    final result = await _repo.getCategoriesOfPlates(id);
    switch (result) {
      case Ok<List<CategoryOfPlateEntity>> data:
        emit(RestaurantsCategoriesLoaded(data.value));
        break;
      case Err<List<CategoryOfPlateEntity>> error:
        emit(RestaurantsCategoriesError(error.error.message));
    }
  }

  @override
  void emit(RestaurantsMenuStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
