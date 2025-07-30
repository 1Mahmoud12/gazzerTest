part of 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class StoreEntity extends GenericVendorEntity {
  ///
  const StoreEntity({
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

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    rate,
    badge,
    priceRange,
    tag,
    startTime,
    endTime,
    subCategories,
    deliveryTime,
    deliveryFee,
    location,
    rateCount,
    parentId,
    alwaysOpen,
    alwaysClosed,
    isFavorite,
    isOpen,
    address,
  ];
}
