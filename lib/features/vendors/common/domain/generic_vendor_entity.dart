import 'package:equatable/equatable.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';

export 'package:gazzer/core/presentation/extensions/enum.dart';

part 'package:gazzer/features/vendors/resturants/domain/enities/restaurant_entity.dart';
part 'package:gazzer/features/vendors/stores/domain/entities/store_entity.dart';

/// generic class for both [RestaurantEntity] for restaurants and [StoreEntity] for stores

sealed class GenericVendorEntity extends Equatable {
  final int id;
  final int? parentId;

  final String name;
  final String image;
  final String location; // zone
  final List<GenericSubCategoryEntity>? subCategories;

  ///
  final String? priceRange;
  final String? deliveryTime;
  final double? deliveryFee;
  final String? badge;
  final List<String>? tag;

  final DateTime? startTime;
  final DateTime? endTime;
  final double rate;
  final int? rateCount;
  final bool alwaysOpen; // is_24_hours
  final bool alwaysClosed;
  final bool isFavorite;
  final bool isOpen;

  final String? address; // ** pending api

  bool get isClosed => alwaysClosed || startTime?.isBefore(DateTime.now()) != true || endTime?.isAfter(DateTime.now()) != true;

  const GenericVendorEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.image,
    this.priceRange,
    required this.rate,
    this.badge,
    this.tag,
    required this.startTime,
    required this.endTime,
    this.subCategories,
    this.deliveryTime,
    this.deliveryFee,
    required this.location,
    this.rateCount,
    required this.alwaysOpen,
    required this.alwaysClosed,
    required this.isFavorite,
    required this.isOpen,
    this.address,
  });

  String? shortTag(int max) {
    if (tag == null || tag!.isEmpty) return null;
    final shortTag = StringBuffer(tag!.first);
    for (var i = 1; i < tag!.length; i++) {
      if (tag![i].length + shortTag.length < max) {
        shortTag.write(', ${tag![i]}');
      } else {
        shortTag.write(', ...');
        break;
      }
    }
    return shortTag.toString();
  }
}
