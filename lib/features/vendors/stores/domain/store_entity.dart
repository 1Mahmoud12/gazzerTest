part of 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class StoreEntity extends GenericVendorEntity {
  ///
  StoreEntity({
    required super.id,
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
    required super.parentId,
    required super.alwaysOpen,
    required super.alwaysClosed,
    required super.isFavorite,
    required super.isOpen,
    super.address,

    // this.categoryOfPlate,
  });
}
