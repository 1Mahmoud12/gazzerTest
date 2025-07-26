import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/error_models.dart';
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

  RestaurantsMenuCubit(this._restRepo, this._bannerRepo) : super(RestaurantsMenuInit());

  final List<(CategoryOfPlateEntity, List<RestaurantEntity>)> cats = [];
  final List<BannerEntity> banners = [];

  Future<void> loadScreenData() async {
    emit(RestaurantsCategoriesLoading());
    await Future.wait([
      _loadCategoriesOfPlates(),
      _getBanners(),
    ]);
    await Future.wait(
      List.generate(cats.length, (index) => _loadVendors(cats[index].$1.id)),
    );
    try {
      emit(RestaurantsCategoriesLoaded(categories: cats.where((e) => e.$2.isNotEmpty).toList(), banners: banners));
    } on BaseError catch (e) {
      emit(RestaurantsCategoriesError(e.message));
    }
  }

  Future<void> _loadCategoriesOfPlates() async {
    final result = await _restRepo.getAllPlatesCategories();
    switch (result) {
      case Ok<List<CategoryOfPlateEntity>> data:
        cats.clear();
        cats.addAll(data.value.map((cat) => (cat, [])));
        break;
      case Err<List<CategoryOfPlateEntity>> error:
        throw error.error;
    }
  }

  Future<void> _loadVendors(int id) async {
    final result = await _restRepo.getRestaurantsOfCategory(1);
    switch (result) {
      case Ok<List<RestaurantEntity>> data:
        cats.firstWhere((cat) => cat.$1.id == id).$2.addAll(data.value);
        break;
      case Err error:
        throw error.error;
    }
  }

  Future<void> _getBanners() async {
    final result = await _bannerRepo.getRestaurantPageBanners();
    switch (result) {
      case Ok<List<BannerEntity>> data:
        banners.clear();
        banners.addAll(data.value);
        break;
      case Err error:
        throw error.error;
    }
  }

  @override
  void emit(RestaurantsMenuStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
