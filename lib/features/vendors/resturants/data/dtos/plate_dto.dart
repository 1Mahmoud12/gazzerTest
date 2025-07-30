import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/utils/color_utils.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

sealed class GenericItemDTO {
  GenericItemDTO();
  GenericItemDTO.fromJson(Map<String, dynamic> json);
  GenericItemEntity toProductItem();
}

class PlateDTO extends GenericItemDTO {
  int? id;
  int? storeId;
  String? plateName;
  int? plateCategoryId;
  String? plateDescription;
  String? otherVariant;
  String? addons;
  String? size;
  double? price;
  double? rate;
  double? appPrice;

  PlateDTO({
    this.id,
    this.storeId,
    this.plateName,
    this.plateCategoryId,
    this.plateDescription,
    this.otherVariant,
    this.addons,
    this.size,
    this.price,
    this.rate,
    this.appPrice,
  });

  PlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    plateName = json['plate_name'];
    plateCategoryId = json['plate_category_id'];
    plateDescription = json['plate_description'];
    otherVariant = json['OtherVariant'];
    addons = json['addons'];
    size = json['size'];
    price = double.tryParse(json['price'].toString());
    rate = double.tryParse(json['rate'].toString());
    appPrice = double.tryParse(json['app_price'].toString());
  }

  @override
  GenericItemEntity toProductItem() {
    return PlateEntity(
      id: id!,
      categoryPlateId: plateCategoryId ?? 0,
      name: plateName ?? '',
      description: plateDescription ?? '',
      image: Fakers.netWorkPRoductImage,
      price: double.tryParse(price.toString()) ?? 0,
      rate: 0.0,
      outOfStock: id?.isEven ?? false,
      badge: '30%',
      reviewCount: 20,
    );
  }

  PlateEntity toPlateEntity() {
    return PlateEntity(
      id: id!,
      categoryPlateId: plateCategoryId ?? 0,
      name: plateName ?? '',
      description: plateDescription ?? '',
      image: Fakers.netWorkPRoductImage,
      price: double.tryParse(price.toString()) ?? 0,
      rate: 0.0,
      outOfStock: id?.isEven ?? false,
      badge: '30%',
      reviewCount: 20,
    );
  }
}

class ProductDTO extends GenericItemDTO {
  int? id;
  String? name;
  String? description;
  double? price;
  double? appPrice;
  int? quantityInStock;
  String? color;
  OfferDTO? offer;
  // ItemUnitBrand? itemUnitBrand;

  /// missing
  List<String>? tags;
  double? rate;
  double? rateCount;
  double? priceBeforeDiscount;

  ProductDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.tryParse(json['price'].toString());
    appPrice = double.tryParse(json['app_price'].toString());
    rate = double.tryParse(json['rate'].toString());
    color = json['color'];
    offer = json['offer'] != null ? OfferDTO.fromJson(json['offer']) : null;
  }

  @override
  ProductEntity toProductItem() {
    return ProductEntity(
      id: id!,
      name: name ?? '',
      price: double.tryParse(appPrice.toString()) ?? 0,
      rate: double.tryParse(rate.toString()) ?? 0,
      color: ColorUtils.safeHexToColor(color),
      offer: offer?.toOfferEntity(),

      ///
      tags: tags,
      description: description ?? '',
      badge: '30%',
      image: Fakers.placeHolderImg,
      reviewCount: 20,
      outOfStock: id?.isEven ?? false,
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
