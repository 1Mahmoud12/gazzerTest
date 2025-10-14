part of 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class PlateEntity extends GenericItemEntity {
  final int categoryPlateId;

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
    super.tags,
    super.offer,
    super.productId,
    super.itemUnitBrand,
    super.store,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    categoryPlateId,
  ];
}
