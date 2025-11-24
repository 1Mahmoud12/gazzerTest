import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class DailyOffersDto {
  DailyOffersDto({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final DailyOffersDtoData? data;

  factory DailyOffersDto.fromJson(Map<String, dynamic> json) {
    return DailyOffersDto(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : DailyOffersDtoData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class DailyOffersDtoData {
  DailyOffersDtoData({
    required this.status,
    required this.message,
    required this.pagination,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<dynamic> pagination;
  final DailyOfferDataModel? data;

  factory DailyOffersDtoData.fromJson(Map<String, dynamic> json) {
    return DailyOffersDtoData(
      status: json["status"],
      message: json["message"],
      pagination: json["pagination"] == null ? [] : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      data: json["data"] == null ? null : DailyOfferDataModel.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "pagination": pagination.map((x) => x).toList(),
    "data": data?.toJson(),
  };
}

class DailyOfferDataModel {
  DailyOfferDataModel({
    required this.storesWithOffers,
    required this.itemsWithOffers,
  });

  final List<StoresWithOffer> storesWithOffers;
  final List<ItemsWithOffer> itemsWithOffers;

  factory DailyOfferDataModel.fromJson(Map<String, dynamic> json) {
    return DailyOfferDataModel(
      storesWithOffers: json["stores_with_offers"] == null
          ? []
          : List<StoresWithOffer>.from(
              json["stores_with_offers"]!.map(
                (x) => StoresWithOffer.fromJson(x),
              ),
            ),
      itemsWithOffers: json["items_with_offers"] == null
          ? []
          : List<ItemsWithOffer>.from(
              json["items_with_offers"]!.map((x) => ItemsWithOffer.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "stores_with_offers": storesWithOffers.map((x) => x.toJson()).toList(),
    "items_with_offers": itemsWithOffers.map((x) => x.toJson()).toList(),
  };
}

class ItemsWithOffer {
  ItemsWithOffer({
    required this.id,
    required this.expiredAt,
    required this.discount,
    required this.discountType,
    required this.maxDiscount,
    required this.itemType,
    required this.item,
  });

  final int? id;
  final DateTime? expiredAt;
  final num? discount;
  final String? discountType;
  final num? maxDiscount;
  final String? itemType;
  final Item? item;

  factory ItemsWithOffer.fromJson(Map<String, dynamic> json) {
    ItemType parsedItemType = ItemType.fromString(
      json["item_type"] ?? 'Unknown',
    );
    Item? parsedItem;

    if (json["item"] != null) {
      if (parsedItemType == ItemType.plate) {
        // For plates, parse via PlateDTO
        final plateDto = PlateDTO.fromJson(json["item"]);
        parsedItem = Item.fromPlateDTO(json["item"], plateDto);
      } else if (parsedItemType == ItemType.product || parsedItemType == ItemType.storeItem) {
        // For products/store items, parse via ProductDTO
        final productDto = ProductDTO.fromJson(json["item"]);
        parsedItem = Item.fromProductDTO(json["item"], productDto);
      } else {
        // Fallback to basic Item parsing
        parsedItem = Item.fromJson(json["item"]);
      }
    }

    return ItemsWithOffer(
      id: json["id"],
      expiredAt: DateTime.tryParse(json["expired_at"] ?? ""),
      discount: json["discount"],
      discountType: json["discount_type"],
      maxDiscount: json["max_discount"],
      itemType: json["item_type"],
      item: parsedItem,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "expired_at": expiredAt?.toIso8601String(),
    "discount": discount,
    "discount_type": discountType,
    "max_discount": maxDiscount,
    "item_type": itemType,
    "item": item?.toJson(),
  };
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.appPrice,
    required this.quantityInStock,
    required this.color,
    required this.offer,
    required this.isFavorite,
    required this.image,
    required this.storeInfo,
  });

  final int? id;
  final String? name;
  final String? price;
  final String? appPrice;
  final num? quantityInStock;
  final String? color;
  final Offer? offer;
  final num? isFavorite;
  final String? image;
  final StoreInfo? storeInfo;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      appPrice: json["app_price"],
      quantityInStock: json["quantity_in_stock"],
      color: json["color"],
      offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
      isFavorite: json["is_favorite"],
      image: json["image"],
      storeInfo: json["store_info"] == null ? null : StoreInfo.fromJson(json["store_info"]),
    );
  }

  // Helper factory for plate items (uses plate_* fields)
  factory Item.fromPlateDTO(Map<String, dynamic> json, PlateDTO plateDto) {
    return Item(
      id: json["id"],
      name: json["plate_name"],
      // Use plate_name for plates
      price: json["price"],
      appPrice: json["app_price"],
      quantityInStock: json["quantity_in_stock"],
      color: json["color"],
      offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
      isFavorite: json["is_favorite"],
      image: json["plate_image"],

      // Use plate_image for plates
      storeInfo: json["store_info"] == null ? null : StoreInfo.fromJson(json["store_info"]),
    );
  }

  // Helper factory for product items (uses standard fields, no plate_* fields)
  factory Item.fromProductDTO(
    Map<String, dynamic> json,
    ProductDTO productDto,
  ) {
    return Item(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      appPrice: json["app_price"],
      quantityInStock: json["quantity_in_stock"],
      color: json["color"],
      offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
      isFavorite: json["is_favorite"],
      image: json["image"],
      storeInfo: json["store_info"] == null ? null : StoreInfo.fromJson(json["store_info"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "app_price": appPrice,
    "quantity_in_stock": quantityInStock,
    "color": color,
    "offer": offer?.toJson(),
    "is_favorite": isFavorite,
    "image": image,
    "store_info": storeInfo?.toJson(),
  };
}

class Offer {
  Offer({
    required this.id,
    required this.expiredAt,
    required this.discount,
    required this.discountType,
    required this.maxDiscount,
  });

  final int? id;
  final DateTime? expiredAt;
  final num? discount;
  final String? discountType;
  final num? maxDiscount;

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json["id"],
      expiredAt: DateTime.tryParse(json["expired_at"] ?? ""),
      discount: json["discount"],
      discountType: json["discount_type"],
      maxDiscount: json["max_discount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "expired_at": expiredAt?.toIso8601String(),
    "discount": discount,
    "discount_type": discountType,
    "max_discount": maxDiscount,
  };
}

class StoreInfo {
  StoreInfo({
    required this.storeCategoryType,
    required this.storeCategoryId,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.isOpen,
  });

  final String? storeCategoryType;
  final int? storeCategoryId;
  final int? storeId;
  final String? storeName;
  final String? storeImage;
  final num? isOpen;

  factory StoreInfo.fromJson(Map<String, dynamic> json) {
    return StoreInfo(
      storeCategoryType: json["store_category_type"],
      storeCategoryId: json["store_category_id"],
      storeId: json["store_id"],
      storeName: json["store_name"],
      storeImage: json["store_image"],
      isOpen: json["is_open"],
    );
  }

  Map<String, dynamic> toJson() => {
    "store_category_type": storeCategoryType,
    "store_category_id": storeCategoryId,
    "store_id": storeId,
    "store_name": storeName,
    "store_image": storeImage,
    "is_open": isOpen,
  };
}

class StoresWithOffer {
  StoresWithOffer({
    required this.id,
    required this.storeName,
    required this.storeType,
    required this.image,
    required this.storeCategoryId,
    required this.storeCategoryType,
    required this.vendorId,
    required this.address,
    required this.estimatedDeliveryTime,
    required this.maxDeliveryTime,
    required this.minDeliveryTime,
    required this.rate,
    required this.rateCount,
    required this.isFavorite,
    required this.isOpen,
    required this.workFrom,
    required this.workTo,
    required this.is24Hours,
    required this.isAlwaysClose,
    required this.closingAlertAppearBefore,
    required this.tags,
    required this.provinceZone,
    required this.offer,
  });

  final int? id;
  final String? storeName;
  final String? storeType;
  final String? image;
  final int? storeCategoryId;
  final String? storeCategoryType;
  final int? vendorId;
  final String? address;
  final num? estimatedDeliveryTime;
  final num? maxDeliveryTime;
  final num? minDeliveryTime;
  final String? rate;
  final num? rateCount;
  final num? isFavorite;
  final num? isOpen;
  final String? workFrom;
  final String? workTo;
  final num? is24Hours;
  final num? isAlwaysClose;
  final num? closingAlertAppearBefore;
  final List<dynamic> tags;
  final ProvinceZone? provinceZone;
  final Offer? offer;

  factory StoresWithOffer.fromJson(Map<String, dynamic> json) {
    return StoresWithOffer(
      id: json["id"],
      storeName: json["store_name"],
      storeType: json["store_type"],
      image: json["image"],
      storeCategoryId: json["store_category_id"],
      storeCategoryType: json["store_category_type"],
      vendorId: json["vendor_id"],
      address: json["address"],
      estimatedDeliveryTime: json["estimated_delivery_time"],
      maxDeliveryTime: json["max_delivery_time"],
      minDeliveryTime: json["min_delivery_time"],
      rate: json["rate"],
      rateCount: json["rate_count"],
      isFavorite: json["is_favorite"],
      isOpen: json["is_open"],
      workFrom: json["work_from"],
      workTo: json["work_to"],
      is24Hours: json["is_24_hours"],
      isAlwaysClose: json["is_always_close"],
      closingAlertAppearBefore: json["closing_alert_appear_before"],
      tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
      provinceZone: json["province_zone"] == null ? null : ProvinceZone.fromJson(json["province_zone"]),
      offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_name": storeName,
    "store_type": storeType,
    "image": image,
    "store_category_id": storeCategoryId,
    "storeCategoryType": storeCategoryType,
    "vendor_id": vendorId,
    "address": address,
    "estimated_delivery_time": estimatedDeliveryTime,
    "max_delivery_time": maxDeliveryTime,
    "min_delivery_time": minDeliveryTime,
    "rate": rate,
    "rate_count": rateCount,
    "is_favorite": isFavorite,
    "is_open": isOpen,
    "work_from": workFrom,
    "work_to": workTo,
    "is_24_hours": is24Hours,
    "is_always_close": isAlwaysClose,
    "closing_alert_appear_before": closingAlertAppearBefore,
    "tags": tags.map((x) => x).toList(),
    "province_zone": provinceZone?.toJson(),
    "offer": offer?.toJson(),
  };
}

class ProvinceZone {
  ProvinceZone({
    required this.id,
    required this.zoneName,
  });

  final int? id;
  final String? zoneName;

  factory ProvinceZone.fromJson(Map<String, dynamic> json) {
    return ProvinceZone(
      id: json["id"],
      zoneName: json["zone_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "zone_name": zoneName,
  };
}
