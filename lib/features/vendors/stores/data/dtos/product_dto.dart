import 'package:gazzer/core/presentation/utils/color_utils.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/data/offer_dto.dart';
import 'package:gazzer/features/vendors/common/data/unit_brand_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class ProductDTO extends GenericItemDTO {
  String? color;
  // ItemUnitBrand? itemUnitBrand;

  /// missing
  // List<String>? tags;
  // double? rate;
  // double? rateCount;
  // double? priceBeforeDiscount;

  ProductDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    productId = json['id'];
    name = json['name'];
    price = double.tryParse(json['app_price'].toString());
    rate = double.tryParse(json['rate'].toString());
    color = json['color'];
    offer = json['offer'] != null ? OfferDTO.fromJson(json['offer']) : null;
    itemUnitBrand = json['item_unit_brand'] != null ? ItemUnitBrandDTO.fromJson(json['item_unit_brand']) : null;
    if (json['store_info'] != null) {
      store = SimpleStoreDTO.fromJson(json['store_info']);
    } else if (json['restaurant_info'] != null) {
      store = SimpleStoreDTO.fromJson(json['restaurant_info']);
    }
    description = json['description'];
    badge = json['badge'];
    image = json['image'];
    rateCount = int.tryParse(json['rate_count'].toString());
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((tag) {
        tags!.add(tag.toString());
      });
    }
  }

  @override
  ProductEntity toEntity() {
    return ProductEntity(
      id: id!,
      productId: productId,
      name: name ?? '',
      price: double.tryParse(price.toString()) ?? 0,
      rate: double.tryParse(rate.toString()) ?? 0,
      color: ColorUtils.safeHexToColor(color),
      offer: offer?.toEntity(),
      itemUnitBrand: itemUnitBrand?.toEntity(),
      store: store?.toEntity(),

      ///
      tags: tags,
      description: description ?? '',
      badge: badge,
      image: image ?? '',
      reviewCount: rateCount ?? 0,
      outOfStock: false,

      // priceBeforeDiscount: double.tryParse(appPrice.toString()) ?? 0,
    );
  }
}
