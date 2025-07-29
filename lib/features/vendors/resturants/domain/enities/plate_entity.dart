part of 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class PlateEntity extends GenericItemEntity {
  final int categoryPlateId;
  final List<PlateOptionsEnitiy> options;

  PlateEntity({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.price,
    required this.categoryPlateId,
    required this.options,
    required super.rate,
    required super.reviewCount,
    required super.outOfStock,
    super.badge,
    super.tags,
    super.offer,
  });
}

class PlateOptionsEnitiy {
  final bool isRequired;
  final String name;
  final bool isMultiple;
  final List<SingleOptionEntity> options;

  PlateOptionsEnitiy({
    required this.isRequired,
    required this.name,
    required this.isMultiple,
    required this.options,
  });
}

class SingleOptionEntity {
  final int id;
  final String name;
  final double price;

  SingleOptionEntity({
    required this.id,
    required this.name,
    required this.price,
  });
}
