part of 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class OrderedWithEntity extends GenericItemEntity {
  const OrderedWithEntity({
    required super.id,
    super.productId,
    required super.name,
    required super.image,
    required super.rate,
    super.description = '',
    required super.price,
    required super.reviewCount,
    required super.outOfStock,

    super.hasOptions = false, // ** as per backend developer, all ordered with has no options.

    super.offer,
    super.tags,
    super.badge,
  });

  @override
  List<Object?> get props => [...super.props];

  @override
  FavoriteType get favoriteType => FavoriteType.plate;
}
