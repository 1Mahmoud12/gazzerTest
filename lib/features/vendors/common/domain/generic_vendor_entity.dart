import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';

part 'package:gazzer/features/vendors/resturants/domain/enities/restaurant_entity.dart';
part 'package:gazzer/features/vendors/stores/domain/entities/store_entity.dart';

/// TODO:
/// emove [VendorEntity] class and use [GenericVendorEntity] instead

/// generic class for both [RestaurantEntity] for restaurants and [StoreEntity] for stores
///
sealed class GenericVendorEntity extends Favorable {
  final int? parentId;
  final String zoneName; // zone
  final List<GenericSubCategoryEntity>? subCategories;
  final int mintsBeforClosingAlert;

  ///
  final String? priceRange;
  final String? storeCategoryType;
  final String? deliveryTime;
  final double? deliveryFee;
  final String? badge;
  final int? totalOrders;
  final int? estimatedDeliveryTime;
  final List<String>? tag;

  final DateTime? startTime;
  final DateTime? endTime;
  final int? rateCount;
  final bool alwaysOpen; // is_24_hours
  final bool alwaysClosed;
  final bool isFavorite;
  final bool isOpen;

  // final String? address; // ** pending api

  bool get isClosed => isOpen == false;

  @override
  FavoriteType get favoriteType => switch (this) {
    RestaurantEntity() => FavoriteType.restaurant,
    StoreEntity() => FavoriteType.store,
  };

  const GenericVendorEntity({
    /// favorable properties
    required super.id,
    required super.name,
    required super.image,
    required super.rate,
    super.description = '',
    required this.mintsBeforClosingAlert,
    required super.outOfStock,
    required super.reviewCount,
    required this.totalOrders,

    ///
    required this.parentId,
    this.priceRange,
    this.estimatedDeliveryTime,
    this.storeCategoryType,
    this.badge,
    this.tag,
    required super.hasOptions,
    required this.startTime,
    required this.endTime,
    this.subCategories,
    this.deliveryTime,
    this.deliveryFee,
    required this.zoneName,
    this.rateCount,
    required this.alwaysOpen,
    required this.alwaysClosed,
    required this.isFavorite,
    required this.isOpen,
    // this.address,
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

  @override
  List<Object?> get props => [
    ...super.props,
    parentId,
    zoneName,
    estimatedDeliveryTime,
    storeCategoryType,
    totalOrders,
    subCategories,
    mintsBeforClosingAlert,
    priceRange,
    deliveryTime,
    deliveryFee,
    badge,
    tag,
    startTime,
    endTime,
    rateCount,
    alwaysOpen,
    alwaysClosed,
    isFavorite,
    isOpen,
  ];
}
