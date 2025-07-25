import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';

export 'package:gazzer/core/presentation/extensions/enum.dart';

part 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';
part 'package:gazzer/features/stores/stores/domain/store_entity.dart';

/// generic class for both [RestaurantEntity] for restaurants and [StoreEntity] for stores

sealed class GenericVendorEntity {
  final int id;
  final String name;
  final String image;
  final String description;
  final String? priceRange;
  final double rate;

  GenericVendorEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    this.priceRange,
    required this.rate,
  });
}
