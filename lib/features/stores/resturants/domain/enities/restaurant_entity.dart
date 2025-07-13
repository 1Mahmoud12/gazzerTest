import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';

class RestaurantEntity {
  final int id;
  final String name;
  final String image;
  final double rate;
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
    required this.id,
    required this.name,
    required this.image,
    this.rate = 0.0,
    this.reviewCount = 0,
    this.estimateDeliveryTime = '',
    this.deliveryFees,
    this.promotionalMessage,
    this.location,
    this.address,
    this.isRestaurant,
    this.storeCategoryId,
    this.categoryOfPlate,
  });
}
