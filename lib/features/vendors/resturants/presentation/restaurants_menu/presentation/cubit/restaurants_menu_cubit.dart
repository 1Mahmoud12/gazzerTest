import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/domain/repos/banner_repo.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';

class RestaurantsMenuCubit extends Cubit<RestaurantsMenuStates> {
  final RestaurantsRepo _restRepo;
  final BannerRepo _bannerRepo;

  RestaurantsMenuCubit(this._restRepo, this._bannerRepo) : super(RestaurantsMenuInit()) {
    gettBanners();
    getCategoriesOfPlates();
  }

  final List<(CategoryOfPlateEntity, List<RestaurantEntity>)> cats = [];
  final List<BannerEntity> banners = [];

  Future<void> gettBanners() async {
    emit(RestaurantsCategoriesLoading());

    final result = await _bannerRepo.getRestaurantPageBanners();
    switch (result) {
      case Ok<List<BannerEntity>> data:
        banners.clear();
        banners.addAll(data.value);
        emit(RestaurantsCategoriesLoaded(categories: cats, banners: banners));

        break;
      case Err error:
        return emit(RestaurantsCategoriesError(error: error.error.message));
    }
  }

  Future<void> getCategoriesOfPlates() async {
    emit(RestaurantsCategoriesLoading());

    final result = await _restRepo.getAllPlatesCategories();
    switch (result) {
      case Ok<List<CategoryOfPlateEntity>> data:
        cats.clear();
        cats.addAll(data.value.map((cat) => (cat, [])));
        emit(RestaurantsCategoriesLoaded(categories: cats, banners: banners));
        break;
      case Err<List<CategoryOfPlateEntity>> error:
        return emit(RestaurantsCategoriesError(error: error.error.message));
    }
  }

  Future<void> getVendors(int id) async {
    emit(VendorsLoading());
    final result = await _restRepo.getRestaurantsOfCategory(id);
    switch (result) {
      case Ok<List<RestaurantEntity>> data:
        cats.firstWhere((cat) => cat.$1.id == id).$2.addAll(data.value);
        emit(VendorsLoaded(categories: cats, banners: banners));
        break;
      case Err error:
        emit(VendorsError(error: error.error.message));
        break;
    }
  }

  @override
  void emit(RestaurantsMenuStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
