import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class RestaurantsMenuStates {
  final List<(CategoryOfPlateEntity, List<RestaurantEntity>)> categories;
  final List<BannerEntity> banners;
  RestaurantsMenuStates({this.categories = const [], this.banners = const []});
}

final class RestaurantsMenuInit extends RestaurantsMenuStates {}

///
/// screen data states
sealed class ScreenDataStates extends RestaurantsMenuStates {
  ScreenDataStates({required super.categories, required super.banners});
}

final class ScreenDataLoading extends ScreenDataStates {
  ScreenDataLoading({super.categories = const [], super.banners = const []});
}

final class ScreenDataLoaded extends ScreenDataStates {
  ScreenDataLoaded({required super.categories, required super.banners});
}

final class ScreenDataError extends ScreenDataStates {
  final String error;

  ScreenDataError({super.categories = const [], super.banners = const [], required this.error});
}

///
///
sealed class RestaurantsCategoriesStates extends RestaurantsMenuStates {
  RestaurantsCategoriesStates({required super.categories, required super.banners});
}

final class RestaurantsCategoriesLoading extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoading({super.categories = const [], super.banners = const []});
}

final class RestaurantsCategoriesLoaded extends RestaurantsCategoriesStates {
  RestaurantsCategoriesLoaded({required super.categories, required super.banners});
}

final class RestaurantsCategoriesError extends RestaurantsCategoriesStates {
  final String error;

  RestaurantsCategoriesError({super.categories = const [], super.banners = const [], required this.error});
}

///
///
sealed class VendorsState extends RestaurantsMenuStates {
  VendorsState({required super.categories, required super.banners});
}

final class VendorsLoading extends VendorsState {
  VendorsLoading({super.categories = const [], super.banners = const []});
}

final class VendorsLoaded extends VendorsState {
  VendorsLoaded({required super.categories, required super.banners});
}

final class VendorsError extends VendorsState {
  final String error;

  VendorsError({super.categories = const [], super.banners = const [], required this.error});
}
