import 'dart:developer';

import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/data/offer_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class DailyOffersWidgetDto {
  final String status;
  final String message;
  final DailyOffersWidgetDataDto? data;

  DailyOffersWidgetDto({required this.status, required this.message, this.data});

  factory DailyOffersWidgetDto.fromJson(Map<String, dynamic> json) {
    return DailyOffersWidgetDto(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? DailyOffersWidgetDataDto.fromJson(json['data']) : null,
    );
  }
}

class DailyOffersWidgetDataDto {
  final List<DailyOfferEntityDto> entities;
  final BannerDTO? banner;

  DailyOffersWidgetDataDto({required this.entities, this.banner});

  factory DailyOffersWidgetDataDto.fromJson(Map<String, dynamic> json) {
    return DailyOffersWidgetDataDto(
      entities: (json['entities'] as List<dynamic>?)?.map((e) => DailyOfferEntityDto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      banner: json['banner'] != null ? BannerDTO.fromJson(json['banner'] as Map<String, dynamic>) : null,
    );
  }
}

/// UNUSED KEYS IN API RESPONSE:
///
/// Banner level (not parsed in BannerDTO):
/// - 'page' - Exists but not parsed
/// - 'bannerable_id' - Exists but commented out (not parsed)
/// - 'button_displayed' - Exists but not parsed
/// - 'button_text' - Exists but not parsed
///
/// Plate items (not parsed in PlateDTO):
/// - 'price' - Exists but not used (using 'app_price' instead)
/// - 'ordered_with' - Exists but not parsed
/// - 'is_favorite' - Exists but not parsed
/// - 'is_have_cart_times' - Exists but not parsed
/// - 'cart_time_quantity' - Exists but not parsed
///
/// Product items (not parsed in ProductDTO):
/// - 'price' - Exists but not used (using 'app_price' instead)
/// - 'is_favorite' - Exists but not parsed
///
/// Stores (not parsed in ProductDTO):
//   "store_category_id": 1,
///  "is_open": 1,
///  "is_busy": 0,
///  "order_count": 234,
///  "rating": "2.50",
///  "store_category_name": "Restaurant",
///  "work_from": "07:00",
///  "work_to": "04:00",
///  "estimated_delivery_time": 26

class DailyOfferEntityDto {
  final int id;
  final String expiredAt;
  final num discount;
  final String discountType;
  final num maxDiscount;
  final String itemType;
  final Map<String, dynamic> item;

  DailyOfferEntityDto({
    required this.id,
    required this.expiredAt,
    required this.discount,
    required this.discountType,
    required this.maxDiscount,
    required this.itemType,
    required this.item,
  });

  factory DailyOfferEntityDto.fromJson(Map<String, dynamic> json) {
    return DailyOfferEntityDto(
      id: json['id'] ?? 0,
      expiredAt: json['expired_at'] ?? '',
      discount: json['discount'] ?? 0,
      discountType: json['discount_type'] ?? '',
      maxDiscount: json['max_discount'] ?? 0,
      itemType: json['item_type'] ?? '',
      item: json['item'] as Map<String, dynamic>,
    );
  }

  GenericItemEntity? toEntity() {
    try {
      final parsedItemType = ItemType.fromString(itemType);

      // Parse item based on type
      GenericItemDTO? parsedItem;
      if (item.isNotEmpty) {
        try {
          if (parsedItemType == ItemType.plate) {
            parsedItem = PlateDTO.fromJson(item);
          } else if (parsedItemType == ItemType.product || parsedItemType == ItemType.storeItem) {
            parsedItem = ProductDTO.fromJson(item);
          } else {
            // Fallback to ProductDTO if type is unknown or unexpected
            parsedItem = ProductDTO.fromJson(item);
          }
        } catch (e, stackTrace) {
          log('Error parsing item for type ${parsedItemType.value}: $e');
          log('Stack trace: $stackTrace');
          return null;
        }
      }

      if (parsedItem == null) return null;

      // Create an OfferDTO from the wrapper's offer data
      final offerDTO = OfferDTO(
        id: id,
        expiredAt: expiredAt,
        discount: discount.toDouble(),
        discountType: discountType,
        maxDiscount: maxDiscount.toInt(),
      );

      // Set the offer on the item (override any existing offer with wrapper's offer)
      parsedItem.offer = offerDTO;

      // Convert the item to entity (which will now have the proper offer)
      return parsedItem.toEntity();
    } catch (e, stackTrace) {
      log('DailyOfferEntityDto.toEntity error for id=$id: $e');
      log('Stack trace: $stackTrace');
      return null;
    }
  }
}
