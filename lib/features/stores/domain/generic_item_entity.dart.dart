export 'package:gazzer/core/presentation/extensions/enum.dart';

part 'package:gazzer/features/stores/resturants/domain/enities/plate_entity.dart';
part 'package:gazzer/features/stores/stores/domain/product_entity.dart';

/// generic class for both [PlateEntity] for restaurants and [ProductEntity] for stores
sealed class GenericItemEntity {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final double? priceBeforeDiscount;
  final double rate;

  GenericItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    this.priceBeforeDiscount,
    required this.rate,
  });
}
