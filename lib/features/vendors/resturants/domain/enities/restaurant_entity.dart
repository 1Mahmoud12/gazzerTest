part of 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class RestaurantEntity extends GenericVendorEntity {
  final int reviewCount;
  final double? deliveryFees;
  final String? promotionalMessage;

  ///
  final String? address;
  final List<CategoryOfPlateEntity>? categoryOfPlate;

  const RestaurantEntity({
    this.reviewCount = 0,
    this.deliveryFees,
    this.promotionalMessage,
    this.address,
    this.categoryOfPlate,
    required super.id,
    required super.parentId,
    required super.name,
    required super.image,
    required super.rate,
    super.badge,
    super.priceRange,
    super.tag,
    required super.startTime,
    required super.endTime,
    super.subCategories,
    super.deliveryTime,
    super.deliveryFee,
    required super.location,
    super.rateCount,
  });
}
