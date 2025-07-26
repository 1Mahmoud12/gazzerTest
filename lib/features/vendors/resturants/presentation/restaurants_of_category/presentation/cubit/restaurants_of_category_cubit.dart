import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/cubit/restaurants_of_category_states.dart';

class RestaurantsOfCategoryCubit extends Cubit<RestaurantsOfCategoryStates> {
  final RestaurantsRepo _repo;
  final int id;
  RestaurantsOfCategoryCubit(this._repo, this.id) : super(RestaurantsOfCategoryInitial()) {
    getPageBanners();
    getTopRatedSection();
    getOffersSection();
    getTodaysSickSection();
    getCategoryRelatedSection();
  }

  Future<void> getTopRatedSection() async {
    emit(TopRatedLoading());
    final result = await _repo.getTopRatedRestaurants(id);
    switch (result) {
      case Ok<List<RestaurantEntity>> ok:
        emit(TopRatedLoaded(restaurants: ok.value));
        break;
      case Err err:
        emit(TopRatedError(err.error.message));
        break;
    }
  }

  Future<void> getOffersSection() async {
    emit(OffersSectionLoading());
    final result = await _repo.getOffersRestaurants(id);
    switch (result) {
      case Ok<List<RestaurantEntity>> ok:
        emit(OffersSectionLoaded(restaurants: ok.value));
        break;
      case Err err:
        emit(OffersSectionError(err.error.message));
        break;
    }
  }

  Future<void> getTodaysSickSection() async {
    emit(TodaysSickSectionLoading());
    final result = await _repo.getTodaysSickRestaurants(id);
    switch (result) {
      case Ok<List<RestaurantEntity>> ok:
        emit(TodaysSickSectionLoaded(restaurants: ok.value));
        break;
      case Err err:
        emit(TodaysSickSectionError(err.error.message));
        break;
    }
  }

  Future<void> getCategoryRelatedSection() async {
    emit(AllRestaurantsOfCategoryLoading());
    final result = await _repo.getRestaurantsOfCategory(id);
    switch (result) {
      case Ok<List<RestaurantEntity>> ok:
        emit(AllRestaurantsOfCategoryLoaded(restaurants: ok.value));
        break;
      case Err err:
        emit(AllRestaurantsOfCategoryError(err.error.message));
        break;
    }
  }

  Future<void> getPageBanners() async {}
}
