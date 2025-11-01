part of 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class RestaurantEntity extends GenericVendorEntity {
  final double? deliveryFees;

  ///
  final List<CategoryOfPlateEntity>? categoryOfPlate;

  const RestaurantEntity({
    this.deliveryFees,
    this.categoryOfPlate,
    required super.id,
    required super.parentId,
    required super.totalOrders,
    required super.name,
    required super.image,
    required super.rate,
    required super.hasOptions,
    super.badge,
    super.priceRange,
    super.tag,
    required super.startTime,
    required super.endTime,
    super.subCategories,
    super.deliveryTime,
    super.deliveryFee,
    required super.zoneName,
    super.rateCount,
    required super.alwaysOpen,
    required super.alwaysClosed,
    required super.isFavorite,
    required super.isOpen,
    required super.mintsBeforClosingAlert,
    super.description,
    required super.outOfStock,
    required super.reviewCount,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    deliveryFees,
    categoryOfPlate,
  ];
}
