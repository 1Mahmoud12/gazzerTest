import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/data/offer_dto.dart';
import 'package:gazzer/features/vendors/common/data/unit_brand_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class PlateDTO extends GenericItemDTO {
  PlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['id'];
    storeId = json['store_id'];
    name = json['plate_name'];
    caegoryId = json['plate_category_id'];
    description = json['plate_description'];
    image = json['plate_image'];
    quantityInStock = json['quantity_in_stock'];
    rate = double.tryParse(json['rate'].toString());
    rateCount = int.tryParse(json['rate_count'].toString());
    price = double.tryParse(json['app_price'].toString());
    hasOptions = json['has_options'] == true;
    badge = json['badge'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((tag) {
        tags!.add(tag.toString());
      });
    }
    if (json['offer'] != null) {
      offer = OfferDTO.fromJson(json['offer']);
    }
    if (json['item_unit_brand'] != null) {
      itemUnitBrand = ItemUnitBrandDTO.fromJson(json['item_unit_brand']);
    }
    if (json['store'] != null) {
      store = SimpleStoreDTO.fromJson(json['store_info']);
    }
  }

  @override
  PlateEntity toEntity() {
    return PlateEntity(
      id: id!,
      productId: productId,
      categoryPlateId: caegoryId ?? 0,
      name: name ?? '',
      description: description ?? '',
      image: image ?? '',
      price: double.tryParse(price.toString()) ?? 0,
      rate: rate ?? 0,
      outOfStock: id?.isEven ?? false,
      badge: badge,
      reviewCount: rateCount ?? 0,
      offer: offer?.toEntity(),
      tags: tags,
      hasOptions: hasOptions ?? false,
      itemUnitBrand: itemUnitBrand?.toEntity(),
      store: store?.toEntity(),
    );
  }
}
