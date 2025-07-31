import 'package:gazzer/features/favorites/domain/favorite_entity.dart';

class FavoriteDto {
  FavoriteDto.fromJson(Map<String, dynamic> json) {}

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: 0,
      name: 'name',
      imageUrl: 'imageUrl',
      type: FavoriteType.unknown,
    );
  }
}
