part '../resturants/domain/enities/plate_entity.dart';
part '../stores/data/product_entity.dart';

/// generic class for both [PlateEntity] for restaurants and [ProductEntity] for stores
sealed class ProductItemEntity {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final double? priceBeforeDiscount;
  final double rate;

  ProductItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    this.priceBeforeDiscount,
    required this.rate,
  });
}
