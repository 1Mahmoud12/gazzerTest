import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class RestaurantsOfCategoryStates {
  final List<RestaurantEntity> restaurants;
  RestaurantsOfCategoryStates({required this.restaurants});
}

sealed class RestaurantsOfCategoryErrorState extends RestaurantsOfCategoryStates {
  final String error;
  RestaurantsOfCategoryErrorState(this.error) : super(restaurants: const []);
}

class RestaurantsOfCategoryInitial extends RestaurantsOfCategoryStates {
  RestaurantsOfCategoryInitial() : super(restaurants: []);
}

///
/// page data states
sealed class RestaurantsOfCategoryPageDataStates extends RestaurantsOfCategoryStates {
  final String name;
  final List<(String, CardStyle, List<RestaurantEntity>)> lists;
  final List<BannerEntity> banners;
  RestaurantsOfCategoryPageDataStates({super.restaurants = const [], this.name = '', this.lists = const [], this.banners = const []});
}

class RestaurantsOfCategoryPageDataLoading extends RestaurantsOfCategoryPageDataStates {
  RestaurantsOfCategoryPageDataLoading()
    : super(restaurants: Fakers.restaurants, lists: [('', CardStyle.typeOne, Fakers.restaurants)], banners: Fakers.banners);
}

class RestaurantsOfCategoryPageDataLoaded extends RestaurantsOfCategoryPageDataStates {
  RestaurantsOfCategoryPageDataLoaded({required super.restaurants, required super.name, required super.lists, required super.banners});
}

class RestaurantsOfCategoryPageDataError extends RestaurantsOfCategoryPageDataStates {
  final String error;
  RestaurantsOfCategoryPageDataError(this.error);
}

///
/// All restaurants of category section
sealed class AllRestaurantsOfCategoryStates extends RestaurantsOfCategoryStates {
  AllRestaurantsOfCategoryStates({required super.restaurants});
}

class AllRestaurantsOfCategoryLoading extends AllRestaurantsOfCategoryStates {
  AllRestaurantsOfCategoryLoading() : super(restaurants: Fakers.restaurants);
}

class AllRestaurantsOfCategoryLoaded extends AllRestaurantsOfCategoryStates {
  AllRestaurantsOfCategoryLoaded({required super.restaurants});
}

class AllRestaurantsOfCategoryError extends RestaurantsOfCategoryErrorState {
  AllRestaurantsOfCategoryError(super.error);
}

///
/// toprated section
sealed class TopRatedStates extends RestaurantsOfCategoryStates {
  TopRatedStates({required super.restaurants});
}

class TopRatedLoading extends TopRatedStates {
  TopRatedLoading() : super(restaurants: Fakers.restaurants);
}

class TopRatedLoaded extends TopRatedStates {
  TopRatedLoaded({required super.restaurants});
}

class TopRatedError extends RestaurantsOfCategoryErrorState {
  TopRatedError(super.error);
}

///
/// offers section
sealed class OffersSectionStates extends RestaurantsOfCategoryStates {
  OffersSectionStates({required super.restaurants});
}

class OffersSectionLoading extends OffersSectionStates {
  OffersSectionLoading() : super(restaurants: Fakers.restaurants);
}

class OffersSectionLoaded extends OffersSectionStates {
  OffersSectionLoaded({required super.restaurants});
}

class OffersSectionError extends RestaurantsOfCategoryErrorState {
  OffersSectionError(super.error);
}

///
/// todays sick section
sealed class TodaysSickSectionStates extends RestaurantsOfCategoryStates {
  TodaysSickSectionStates({required super.restaurants});
}

class TodaysSickSectionLoading extends TodaysSickSectionStates {
  TodaysSickSectionLoading() : super(restaurants: const []);
}

class TodaysSickSectionLoaded extends TodaysSickSectionStates {
  TodaysSickSectionLoaded({required super.restaurants});
}

class TodaysSickSectionError extends RestaurantsOfCategoryErrorState {
  TodaysSickSectionError(super.error);
}
