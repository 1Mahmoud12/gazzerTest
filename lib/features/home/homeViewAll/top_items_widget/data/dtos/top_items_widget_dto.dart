import 'dart:developer';

import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class TopItemsWidgetDto {
  final String status;
  final String message;
  final TopItemsWidgetDataDto? data;

  TopItemsWidgetDto({required this.status, required this.message, this.data});

  factory TopItemsWidgetDto.fromJson(Map<String, dynamic> json) {
    return TopItemsWidgetDto(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? TopItemsWidgetDataDto.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}

class TopItemsWidgetDataDto {
  final List<TopItemEntityDto> entities;
  final BannerDTO? banner;

  TopItemsWidgetDataDto({required this.entities, this.banner});

  factory TopItemsWidgetDataDto.fromJson(Map<String, dynamic> json) {
    return TopItemsWidgetDataDto(
      entities: (json['entities'] as List<dynamic>?)?.map((e) => TopItemEntityDto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      banner: json['banner'] != null ? BannerDTO.fromJson(json['banner'] as Map<String, dynamic>) : null,
    );
  }

  List<GenericItemEntity> toEntities() {
    return entities.map((e) => e.toEntity()).whereType<GenericItemEntity>().toList();
  }
}

class TopItemEntityDto {
  final int id;
  final String itemType;
  final int itemId;
  final Map<String, dynamic> item;

  TopItemEntityDto({required this.id, required this.itemType, required this.itemId, required this.item});

  factory TopItemEntityDto.fromJson(Map<String, dynamic> json) {
    return TopItemEntityDto(
      id: json['id'] ?? 0,
      itemType: json['item_type'] ?? '',
      itemId: json['item_id'] ?? 0,
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
      return parsedItem.toEntity();
    } catch (e, stackTrace) {
      log('TopItemEntityDto.toEntity error for id=$id: $e');
      log('Stack trace: $stackTrace');
      return null;
    }
  }
}
