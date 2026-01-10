part of 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class PlateEntity extends GenericItemEntity {
  final int categoryPlateId;
  @override
  final int sold;

  const PlateEntity({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.price,
    required super.rate,
    required super.reviewCount,
    required super.outOfStock,
    required this.categoryPlateId,
    required super.hasOptions,
    super.badge,
    required this.sold,
    super.tags,
    super.offer,
    super.productId,
    super.itemUnitBrand,
    super.store,
    super.orderCount,
  });

  @override
  List<Object?> get props => [...super.props, categoryPlateId, sold];
}
