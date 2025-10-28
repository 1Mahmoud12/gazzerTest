import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class SingleRestaurantStates {
  final RestaurantEntity restaurant;
  final List<PlateEntity> toprated;
  final List<PlateEntity> bestSelling;
  final List<(CategoryOfPlateEntity, List<PlateEntity>)> categoriesWithPlates;
  final List<BannerEntity> banners;
  bool get isSingle => categoriesWithPlates.length < 2;
  const SingleRestaurantStates({
    this.restaurant = Fakers.restaurant,
    this.toprated = const [],
    this.bestSelling = const [],
    this.categoriesWithPlates = const [],
    this.banners = const [],
  });
}

final class SingleRestaurantInitial extends SingleRestaurantStates {}

final class SingleRestaurantLoading extends SingleRestaurantStates {}

final class SingleRestaurantLoaded extends SingleRestaurantStates {
  const SingleRestaurantLoaded({
    required super.restaurant,
    required super.toprated,
    required super.bestSelling,
    required super.categoriesWithPlates,
    required super.banners,
  });
}

final class SingleRestaurantError extends SingleRestaurantStates {
  final String error;
  const SingleRestaurantError({required this.error});
}
