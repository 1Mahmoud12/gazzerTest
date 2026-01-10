import 'package:gazzer/core/data/dto/store_info_dto.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

part 'category_dto.dart';

sealed class ProductItemDTO {
  ProductItemDTO();

  ProductItemDTO.fromJson();
}

class SectionItemDTO extends ProductItemDTO {
  int? id;
  String? expiredAt;
  int? discount;
  late final ItemType itemType;
  GenericItemDTO? item;

  GenericItemEntity? toEntity() {
    switch (itemType) {
      case ItemType.plate:
        return item?.toEntity();
      case ItemType.product:
        return item?.toEntity();
      case ItemType.storeItem:
        return item?.toEntity();
      default:
        // throw Exception('Unsupported item? type: $item?Type');
        // return item?.toProductItem();
        return null;
    }
  }

  SectionItemDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : (json['item_id'] != null && json['item_id'] is int)
        ? json['item_id']
        : -1;
    expiredAt = json['expired_at'];
    discount = json['discount'];

    itemType = ItemType.fromString(json['item_type'] ?? 'Unknown');
    if (json['item'] != null) {
      try {
        if (itemType == ItemType.plate) {
          item = PlateDTO.fromJson(json['item']);
        } else if (itemType == ItemType.product || itemType == ItemType.storeItem) {
          item = ProductDTO.fromJson(json['item']);
        } else {
          // Try to parse as ProductDTO as fallback
          item = ProductDTO.fromJson(json['item']);
        }
      } catch (e) {
        // If parsing fails, item remains null
        item = null;
      }
    }
    // if (json['item'] != null) {
    //   item = <Null>[];
    //   json['item'].forEach((v) {
    //     item!.add(new Null.fromJson(v));
    //   });
    // }
  }
}
