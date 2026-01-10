import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/category_of_plate_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_dto.dart';

class RestaurantPageResponse {
  late final RestaurantEntity restaurant;
  late final List<PlateEntity> topRated;
  late final List<PlateEntity> bestSelling;
  late final List<(CategoryOfPlateEntity, List<PlateEntity>)>
  categoriesWithPlates;
  late final List<BannerEntity> banners;

  RestaurantPageResponse.fromJson(Map<String, dynamic> json) {
    if (json['restaurant'] is Map) {
      restaurant = RestaurantDTO.fromJson(json['restaurant']).toRestEntity();
    } else {
      throw 'Restaurant data is missing';
    }
    if (json['plate_categories'] != null) {
      categoriesWithPlates = [];
      for (final item in json['plate_categories']) {
        final category = CategoryOfPlateDTO.fromJson(
          item,
        ).toCategoryOfPlateEntity();
        final plates = <PlateEntity>[];
        if (item['plates'] != null) {
          for (final plate in item['plates']) {
            plates.add(PlateDTO.fromJson(plate).toEntity());
          }
        }
        plates.sort((a, b) => a.outOfStock ? 1 : -1);

        if (plates.isNotEmpty) categoriesWithPlates.add((category, plates));
      }
    }
    topRated = [];
    if (json['top_rated_plates'] != null) {
      for (final item in json['top_rated_plates']) {
        topRated.add(PlateDTO.fromJson(item).toEntity());
      }
    }
    topRated.sort((a, b) => a.outOfStock ? 1 : -1);

    bestSelling = [];
    if (json['best_selling_items'] != null) {
      for (final item in json['best_selling_items']) {
        bestSelling.add(PlateDTO.fromJson(item).toEntity());
      }
    }
    bestSelling.sort((a, b) => a.outOfStock ? 1 : -1);

    banners = [];
    if (json['banners'] != null) {
      for (final item in json['banners']) {
        banners.add(BannerDTO.fromJson(item).toEntity());
      }
    }
  }
}
