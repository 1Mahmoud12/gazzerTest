import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entityy.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/category_of_plate_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_dto.dart';

class RestaurantsMenuReponse {
  late final List<BannerEntity> banners;
  late final List<(CategoryOfPlateEntity, List<RestaurantEntity>)> categoryWithrestaurants;

  // RestaurantsMenuReponse({
  //   required this.banners,
  //   required this.categoryWithrestaurants,
  // });

  RestaurantsMenuReponse.fromJson(Map<String, dynamic> json) {
    banners = <BannerEntity>[];
    if (json['banners'] != null) {
      for (var item in json['banners']) {
        banners.add(BannerDTO.fromJson(item).toEntity());
      }
    }
    categoryWithrestaurants = <(CategoryOfPlateEntity, List<RestaurantEntity>)>[];
    if (json['categories'] != null) {
      for (var item in json['categories']) {
        final category = CategoryOfPlateDTO.fromJson(item).toCategoryOfPlateEntity();
        final restaurants = <RestaurantEntity>[];
        if (item['restaurants'] != null) {
          for (var rest in item['restaurants']) {
            restaurants.add(RestaurantDTO.fromJson(rest).toRestEntity());
          }
        }
        categoryWithrestaurants.add((category, restaurants));
      }
    }
  }
}
