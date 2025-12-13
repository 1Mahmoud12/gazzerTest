import 'dart:developer';

import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class SuggestsWidgetDto {
  final String status;
  final String message;
  final SuggestsWidgetDataDto? data;

  SuggestsWidgetDto({required this.status, required this.message, this.data});

  factory SuggestsWidgetDto.fromJson(Map<String, dynamic> json) {
    return SuggestsWidgetDto(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? SuggestsWidgetDataDto.fromJson(json['data']) : null,
    );
  }
}

class SuggestsWidgetDataDto {
  final List<SuggestEntityDto> entities;
  final BannerDTO? banner;

  SuggestsWidgetDataDto({required this.entities, this.banner});

  factory SuggestsWidgetDataDto.fromJson(Map<String, dynamic> json) {
    return SuggestsWidgetDataDto(
      entities: (json['entities'] as List<dynamic>?)?.map((e) => SuggestEntityDto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      banner: json['banner'] != null ? BannerDTO.fromJson(json['banner'] as Map<String, dynamic>) : null,
    );
  }
}

/// UNUSED KEYS IN API RESPONSE:
///
/// Entity level (SuggestEntityDto):
/// - 'recommendation_type' - Parsed but never used (stored in DTO but not passed to entity)
/// - 'score' - Parsed but never used (stored in DTO but not passed to entity)
/// - 'item_id' - Parsed but never used (stored in DTO but not passed to entity)
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
/// Store info (not parsed in SimpleStoreDTO):
/// - 'store_category_id' - Exists but not parsed
/// - 'is_open' - Exists but not parsed
/// - 'is_busy' - Exists but not parsed
/// - 'order_count' - Exists but not parsed
/// - 'rating' - Exists but not parsed
/// - 'store_category_name' - Exists but not parsed
/// - 'work_from' - Exists but not parsed
/// - 'work_to' - Exists but not parsed
/// - 'estimated_delivery_time' - Exists but not parsed

class SuggestEntityDto {
  final int id;
  final String itemType;
  final int itemId;
  final Map<String, dynamic> item;
  final String recommendationType;
  final num score;

  SuggestEntityDto({
    required this.id,
    required this.itemType,
    required this.itemId,
    required this.item,
    required this.recommendationType,
    required this.score,
  });

  factory SuggestEntityDto.fromJson(Map<String, dynamic> json) {
    return SuggestEntityDto(
      id: json['id'] ?? 0,
      itemType: json['item_type'] ?? '',
      itemId: json['item_id'] ?? 0,
      item: json['item'] as Map<String, dynamic>,
      recommendationType: json['recommendation_type'] ?? '',
      score: json['score'] ?? 0,
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

      // Convert the item to entity
      return parsedItem.toEntity();
    } catch (e, stackTrace) {
      log('SuggestEntityDto.toEntity error for id=$id: $e');
      log('Stack trace: $stackTrace');
      return null;
    }
  }
}
