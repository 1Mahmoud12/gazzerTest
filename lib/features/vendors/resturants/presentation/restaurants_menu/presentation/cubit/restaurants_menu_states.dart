import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';

sealed class RestaurantsMenuStates {}

final class RestaurantsMenuInit extends RestaurantsMenuStates {}

sealed class RestaurantsCategoriesStates extends RestaurantsMenuStates {
  final List<(CategoryOfPlateEntity, List<RestaurantEntity>)> categories;
  final List<BannerEntity> banners;
  RestaurantsCategoriesStates({this.categories = const [], this.banners = const []});
}

final class RestaurantsCategoriesLoading extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoading();
}

final class RestaurantsCategoriesLoaded extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoaded({required super.categories, required super.banners});
}

final class RestaurantsCategoriesError extends RestaurantsCategoriesStates {
  final String error;
  RestaurantsCategoriesError(this.error);
}

// sealed class VendorsState extends RestaurantsMenuStates {
//   final int categoryId;
//   final List<GenericVendorEntity> vendors;
//   VendorsState({required this.categoryId, this.vendors = const []});
// }

// final class VendorsLoading extends VendorsState {
//   VendorsLoading({required super.categoryId});
// }

// final class VendorsLoaded extends VendorsState {
//   VendorsLoaded({required super.categoryId, required super.vendors});
// }

// final class VendorsError extends VendorsState {
//   final String error;
//   VendorsError({required super.categoryId, required this.error});
// }
