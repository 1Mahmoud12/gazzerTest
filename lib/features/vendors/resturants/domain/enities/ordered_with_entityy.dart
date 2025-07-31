part of 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class OrderedWithEntity extends GenericItemEntity {
  const OrderedWithEntity({
    required super.id,
    required super.name,
    required super.image,
    required super.rate,
    super.description = '',
    required super.price,
    required super.reviewCount,
    required super.outOfStock,
    super.offer,
    super.tags,
    super.badge,
  });

  @override
  List<Object?> get props => [id, name, image, rate, price];

  @override
  FavoriteType get favoriteType => FavoriteType.plate;
}
