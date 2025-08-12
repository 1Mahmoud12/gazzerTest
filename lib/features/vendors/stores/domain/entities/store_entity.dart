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
    required super.zoneName,
    super.rateCount,
    required super.parentId,
    required super.alwaysOpen,
    required super.alwaysClosed,
    required super.isFavorite,
    required super.isOpen,
    required super.mintsBeforClosingAlert,
    super.description,

    // this.categoryOfPlate,
  });

  @override
  List<Object?> get props => [...super.props];
}
