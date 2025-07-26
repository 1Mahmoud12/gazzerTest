import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';

export 'package:gazzer/core/presentation/extensions/enum.dart';

part 'package:gazzer/features/vendors/groceries/domain/store_entity.dart';
part 'package:gazzer/features/vendors/resturants/domain/enities/restaurant_entity.dart';

/// generic class for both [RestaurantEntity] for restaurants and [StoreEntity] for stores

sealed class GenericVendorEntity {
  final int id;
  final int? parentId;

  final String name;
  final String image;
  final String description;
  final String location; // zone
  final List<GenericSubCategoryEntity>? subCategories;

  ///
  final String? priceRange;
  final String? deliveryTime;
  final double? deliveryFee;
  final String? badge;
  final String? tag;

  final bool isClosed;
  final DateTime startTime;
  final DateTime endTime;
  final double rate;
  final int? rateCount;

  const GenericVendorEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.image,
    required this.description,
    this.priceRange,
    required this.rate,
    required this.isClosed,
    this.badge,
    this.tag,
    required this.startTime,
    required this.endTime,
    this.subCategories,
    this.deliveryTime,
    this.deliveryFee,
    required this.location,
    this.rateCount,
  });
}

class GenericSubCategoryEntity {
  final int id;
  final String name;
  final String? image;

  const GenericSubCategoryEntity({
    required this.id,
    required this.name,
    required this.image,
  });
}
