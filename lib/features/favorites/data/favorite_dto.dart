import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/restaurant_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_dto.dart';

class FavoriteDto {
  late final String type;
  late final Map<String, dynamic> item;
  FavoriteDto.fromJson(Map<String, dynamic> json) {
    type = json['favoritable_type'].toString();
    item = json['favoritable'];
  }

  Favorable toEntity() {
    final favType = FavoriteType.fromString(type);
    switch (favType) {
      case FavoriteType.restaurant:
        return RestaurantDTO.fromJson(item).toRestEntity();
      case FavoriteType.store:
        return StoreDTO.fromJson(item).toEntity();
      case FavoriteType.plate:
        return PlateDTO.fromJson(item).toEntity();
      case FavoriteType.product:
        return ProductDTO.fromJson(item).toEntity();
      default:
        throw Exception('Unknown favorite type: $favType');
    }
  }
}
