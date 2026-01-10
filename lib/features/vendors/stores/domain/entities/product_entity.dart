part of 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class ProductEntity extends GenericItemEntity {
  final Color? color;
  final int? quantityInStock;
  @override
  final int? sold;

  ///

  const ProductEntity({
    required super.id,
    super.productId,
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    required super.rate,
    required super.reviewCount,
    required super.outOfStock,
    required this.sold,
    super.hasOptions = false, // ** as per backend developer, all store-items has no options.
    super.badge,
    super.tags,
    super.itemUnitBrand,
    super.store,
    super.orderCount,

    ///
    this.color,
    super.offer,
    this.quantityInStock,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [...super.props, color, sold, quantityInStock];
}
