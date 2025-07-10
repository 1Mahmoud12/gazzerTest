import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';

class RestaurantEntity {
  final int id;
  final String name;
  final String logo;
  final double? rate;
  final String? estimateDeliveryTime;
  final double? deliveryFees;
  final String? promotionalMessage;

  ///
  final String? location;
  final String? address;
  final int? isRestaurant;
  final int? storeCategoryId;
  final List<CategoryOfPlateEntity>? subcategories;

  RestaurantEntity({
    required this.id,
    required this.name,
    required this.logo,
    this.rate,
    this.estimateDeliveryTime,
    this.deliveryFees,
    this.promotionalMessage,
    this.location,
    this.address,
    this.isRestaurant,
    this.storeCategoryId,
    this.subcategories,
  });
}
