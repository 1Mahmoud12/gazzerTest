import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_dto.dart';

class RestaurantsOfCategoryyResponse {
  late final String name;
  late final List<(String name, CardStyle, List<RestaurantEntity>)> lists;
  late final List<RestaurantEntity> restaurants;
  late final List<BannerEntity> banners;

  RestaurantsOfCategoryyResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    banners = <BannerEntity>[];
    if (json['banners'] != null) {
      for (var item in json['banners']) {
        banners.add(BannerDTO.fromJson(item).toEntity());
      }
    }
    lists = <(String, CardStyle, List<RestaurantEntity>)>[];
    if (json['lists'] != null) {
      for (var item in json['lists']) {
        final name = item['name'].toString();
        final style = CardStyle.fromString(item['style'].toString());
        final restaurants = <RestaurantEntity>[];
        if (item['restaurants'] != null) {
          for (var rest in item['restaurants']) {
            restaurants.add(RestaurantDTO.fromJson(rest).toRestEntity());
          }
        }
        lists.add((name, style, restaurants));
      }
    }
    restaurants = <RestaurantEntity>[];
    if (json['restaurants'] != null) {
      for (var item in json['restaurants']) {
        restaurants.add(RestaurantDTO.fromJson(item).toRestEntity());
      }
    }
  }
}
