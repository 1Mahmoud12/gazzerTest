import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/home/main_home/data/product_item_dto.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_dto.dart';

class RestaurantsMenuReponse {
  late final List<BannerEntity> banners;
  late final String name;
  late final List<(CategoryEntity, List<RestaurantEntity>)> categoryWithrestaurants;

  // RestaurantsMenuReponse({
  //   required this.banners,
  //   required this.name,
  //   required this.categoryWithrestaurants,
  // });

  RestaurantsMenuReponse.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    banners = <BannerEntity>[];
    if (json['banners'] != null) {
      for (var item in json['banners']) {
        banners.add(BannerDTO.fromJson(item).toEntity());
      }
    }
    categoryWithrestaurants = <(CategoryEntity, List<RestaurantEntity>)>[];
    if (json['categories'] != null) {
      for (var item in json['categories']) {
        final category = CategoryDTO.fromJson(item).toCategoryEntity();
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
