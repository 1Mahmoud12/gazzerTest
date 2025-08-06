import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_page_response.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_states.dart';

class SingleRestaurantCubit extends Cubit<SingleRestaurantStates> {
  final RestaurantsRepo _repo;
  final int id;
  SingleRestaurantCubit(this._repo, this.id) : super(SingleRestaurantInitial()) {
    loadSingleRestaurantData();
  }

  Future<void> loadSingleRestaurantData() async {
    emit(SingleRestaurantLoading());

    final result = await _repo.loadRestaurantPage(id);
    switch (result) {
      case Ok<RestaurantPageResponse> ok:
        emit(
          SingleRestaurantLoaded(
            restaurant: ok.value.restaurant,
            toprated: ok.value.topRated,
            categoriesWithPlates: ok.value.categoriesWithPlates,
            banners: ok.value.banners,
          ),
        );
        break;
      case Err err:
        emit(SingleRestaurantError(error: err.error.message));
        break;
    }
  }

  @override
  void emit(SingleRestaurantStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
