part of 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class ProductEntity extends GenericItemEntity {
  ///
  final int? storeId;

  ProductEntity({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    super.priceBeforeDiscount,
    this.storeId,
    required super.rate,
    required super.reviewCount  ,
    required super.outOfStock,
    super.badge,
  });
}
