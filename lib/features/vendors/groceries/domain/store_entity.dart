part of 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class StoreEntity extends GenericVendorEntity {
  final int reviewCount;
  final String estimateDeliveryTime;
  final double? deliveryFees;
  final String? promotionalMessage;

  ///
  final String? address;
  final bool? isRestaurant;
  final int? storeCategoryId;
  // final List<CategoryOfPlateEntity>? categoryOfPlate;

  StoreEntity({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.rate,
    required super.isClosed,
    super.badge,
    super.priceRange,
    this.reviewCount = 0,
    this.estimateDeliveryTime = '',
    this.deliveryFees,
    this.promotionalMessage,
    this.address,
    this.isRestaurant,
    this.storeCategoryId,
    super.tag,
    required super.startTime,
    required super.endTime,
    super.subCategories,
    super.deliveryTime,
    super.deliveryFee,
    required super.location,
    super.rateCount,
    required super.parentId,
    
    // this.categoryOfPlate,
  });
}
