import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_dto.dart';

class RestaurantsOfCategoryyResponse {
  late final String name;
  late final List<(String name, CardStyle, List<RestaurantEntity>)> lists;
  late final List<RestaurantEntity> restaurants;
  late final List<BannerEntity> banners;

  RestaurantsOfCategoryyResponse.fromJson(Map<String, dynamic> json) {
    name = json['plate_category'] is Map ? json['plate_category']['name'].toString() : '';
    banners = <BannerEntity>[];
    if (json['banners'] != null) {
      for (final item in json['banners']) {
        banners.add(BannerDTO.fromJson(item).toEntity());
      }
    }
    lists = <(String, CardStyle, List<RestaurantEntity>)>[];
    if (json['lists'] != null) {
      for (final item in json['lists']) {
        final name = item['name'].toString();
        final style = CardStyle.fromString(item['card_style'].toString());
        final listRestaurants = <RestaurantEntity>[];
        if (item['entities'] != null) {
          for (final rest in item['entities']) {
            listRestaurants.add(RestaurantDTO.fromJson(rest).toRestEntity());
          }
        }
        listRestaurants.sort((a, b) => a.isClosed ? 1 : -1);
        lists.add((name, style, listRestaurants));
      }
    }
    restaurants = <RestaurantEntity>[];
    if (json['restaurants'] != null) {
      for (final item in json['restaurants']) {
        restaurants.add(RestaurantDTO.fromJson(item).toRestEntity());
      }
      restaurants.sort((a, b) => a.isClosed ? 1 : -1);
    }
  }
}
