import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/stores/domain/store_item_entity.dart.dart';
import 'package:gazzer/features/stores/resturants/data/dtos/plate_dto.dart';

part 'category_dto.dart';

sealed class SectionItem {
  SectionItem();
  SectionItem.fromJson(Map<String, dynamic> json);
}

enum ItemType {
  plate('plate'),
  product('product'),
  unknown('Unknown');

  final String value;
  const ItemType(this.value);

  static ItemType fromString(String type) {
    return ItemType.values.firstWhere((e) => e.value.toLowerCase() == type, orElse: () => ItemType.unknown);
  }
}

class SectionItemDTO extends SectionItem {
  int? id;
  String? expiredAt;
  int? discount;
  late final ItemType itemType;
  StoreItemDTO? item;

  ProductItemEntity? toEntity() {
    switch (itemType) {
      case ItemType.plate:
        return item?.toProductItem() as PlateEntity;
      case ItemType.product:
        return item?.toProductItem() as ProductEntity;
      default:
        // throw Exception('Unsupported item? type: $item?Type');
        return item?.toProductItem();
    }
  }

  SectionItemDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expiredAt = json['expired_at'];
    discount = json['discount'];
    itemType = ItemType.fromString(json['item_type'] ?? 'Unknown');
    if (itemType == ItemType.plate) {
      item = PlateDTO.fromJson(json['item']);
    } else if (itemType == ItemType.product) {
      // item = ProductItemDTO.fromJson(json['item']);
    } else {
      // item = ProductItemDTO.fromJson(json['item']);
    }
    // if (json['item'] != null) {
    //   item = <Null>[];
    //   json['item'].forEach((v) {
    //     item!.add(new Null.fromJson(v));
    //   });
    // }
  }
}
