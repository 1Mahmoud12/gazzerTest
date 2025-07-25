part of 'package:gazzer/features/stores/domain/generic_vendor_entity.dart';

class RestaurantEntity extends GenericVendorEntity {
  final int reviewCount;
  final String estimateDeliveryTime;
  final double? deliveryFees;
  final String? promotionalMessage;

  ///
  final String? location;
  final String? address;
  final bool? isRestaurant;
  final int? storeCategoryId;
  final List<CategoryOfPlateEntity>? categoryOfPlate;

  RestaurantEntity({
    this.reviewCount = 0,
    this.estimateDeliveryTime = '',
    this.deliveryFees,
    this.promotionalMessage,
    this.location,
    this.address,
    this.isRestaurant,
    this.storeCategoryId,
    this.categoryOfPlate,
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.rate,
  });
}
