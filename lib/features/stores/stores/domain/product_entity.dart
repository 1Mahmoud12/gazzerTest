part of 'package:gazzer/features/stores/domain/generic_item_entity.dart.dart';

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
  });
}
