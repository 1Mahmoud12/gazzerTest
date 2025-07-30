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
    super.badge,
    super.tags,
    super.offer,
  });

  @override
  List<Object?> get props => [
    super.id,
    super.name,
    super.description,
    super.image,
    super.price,
    super.rate,
    super.reviewCount,
    super.outOfStock,
    categoryPlateId,
    categoryPlateId,
  ];
}

class PlateOptionEntity extends Equatable {
  final int id;
  final String name;
  final bool isRequired;
  final OptionType type;
  final bool controlsPrice;
  final List<OpionValueEntity> values;

  const PlateOptionEntity({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.type,
    required this.controlsPrice,
    required this.values,
  });

  @override
  List<Object?> get props => [id, name, isRequired, type, controlsPrice, values];
}

class OpionValueEntity extends Equatable {
  final int id;
  final String name;
  final double price;
  final bool isDefault;
  const OpionValueEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [id, name, price, isDefault];
}
