part of 'package:gazzer/features/stores/domain/store_item_entity.dart.dart';

class ProductEntity extends ProductItemEntity {
  final int id;
  final int? storeId;
  final String name;
  final String? description;
  final double price;

  ProductEntity({
    required this.id,
    required this.storeId,
    required this.name,
    this.description,
    required this.price,
  });
}
