import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/utils/color_utils.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

sealed class GenericItemDTO {
  int? id;
  int? storeId;
  int? caegoryId;
  String? name;
  String? image;
  String? description;
  double? price;
  int? quantityInStock;
  OfferDTO? offer;
  // ItemUnitBrand? itemUnitBrand;

  /// missing
  List<String>? tags;
  String? badge;
  double? rate;
  int? rateCount;
  double? priceBeforeDiscount;

  GenericItemDTO({
    this.id,
    this.storeId,
    this.caegoryId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.quantityInStock,
    this.offer,
    // this.itemUnitBrand,
    this.tags,
    this.rate,
    this.rateCount,
    this.priceBeforeDiscount,
  });
  GenericItemDTO.fromJson(Map<String, dynamic> json);
  GenericItemEntity toEntity();
}

class PlateDTO extends GenericItemDTO {
  PlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    name = json['plate_name'];
    caegoryId = json['plate_category_id'];
    description = json['plate_description'];
    image = json['plate_image'];
    rate = double.tryParse(json['rate'].toString());
    rateCount = int.tryParse(json['rate_count'].toString());
    price = double.tryParse(json['app_price'].toString());
    badge = json['badge'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((tag) {
        tags!.add(tag.toString());
      });
    }
  }

  @override
  PlateEntity toEntity() {
    return PlateEntity(
      id: id!,
      categoryPlateId: caegoryId ?? 0,
      name: name ?? '',
      description: description ?? '',
      image: image ?? '',
      price: double.tryParse(price.toString()) ?? 0,
      rate: rate ?? 0,
      outOfStock: id?.isEven ?? false,
      badge: badge,
      reviewCount: rateCount ?? 0,
      offer: offer?.toOfferEntity(),
      tags: tags,
    );
  }
}

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
    name = json['name'];
    price = double.tryParse(json['app_price'].toString());
    rate = double.tryParse(json['rate'].toString());
    color = json['color'];
    offer = json['offer'] != null ? OfferDTO.fromJson(json['offer']) : null;
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
      name: name ?? '',
      price: double.tryParse(price.toString()) ?? 0,
      rate: double.tryParse(rate.toString()) ?? 0,
      color: ColorUtils.safeHexToColor(color),
      offer: offer?.toOfferEntity(),

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

class OfferDTO {
  int? id;
  String? expiredAt;
  double? discount;
  String? discountType;
  int? maxDiscount;

  OfferDTO({this.id, this.expiredAt, this.discount, this.discountType, this.maxDiscount});

  OfferDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expiredAt = json['expired_at'];
    discount = double.tryParse(json['discount'].toString());
    discountType = json['discount_type'];
    maxDiscount = json['max_discount'];
  }
  Offer? toOfferEntity() {
    if (discount == null || discountType == null) return null;
    return Offer(
      id: id ?? 0,
      expiredAt: expiredAt ?? '',
      discount: discount ?? 0,
      discountType: DiscountType.fromString(discountType ?? ''),
    );
  }
}
