import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/data/offer_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class DailyOffersDto {
  DailyOffersDto({
    required this.status,
    required this.message,
    required this.data,
    this.pagination,
  });

  final String? status;
  final String? message;
  final DailyOfferDataModel? data;
  final PaginationInfo? pagination;

  factory DailyOffersDto.fromJson(Map<String, dynamic> json) {
    return DailyOffersDto(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : DailyOfferDataModel.fromJson(json["data"]),
      pagination: json["pagination"] == null ? null : PaginationInfo.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "pagination": pagination?.toJson(),
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
  ItemsWithOffer._({
    this.id,
    this.expiredAt,
    this.discount,
    this.discountType,
    this.maxDiscount,
    this.item,
  });

  final int? id;
  final String? expiredAt;
  final num? discount;
  final String? discountType;
  final num? maxDiscount;
  late final ItemType itemType;
  GenericItemDTO? item;

  factory ItemsWithOffer.fromJson(Map<String, dynamic> json) {
    // Extract values first
    final id = json["id"];
    final expiredAt = json["expired_at"];
    final discount = json["discount"];
    final discountType = json["discount_type"];
    final maxDiscount = json["max_discount"];

    // Parse item type
    final parsedItemType = ItemType.fromString(json["item_type"] ?? 'Unknown');

    // Parse item based on type
    GenericItemDTO? parsedItem;
    if (json["item"] != null) {
      try {
        if (parsedItemType == ItemType.plate) {
          parsedItem = PlateDTO.fromJson(json["item"]);
        } else if (parsedItemType == ItemType.product || parsedItemType == ItemType.storeItem) {
          parsedItem = ProductDTO.fromJson(json["item"]);
        } else {
          // Fallback to ProductDTO if type is unknown or unexpected
          parsedItem = ProductDTO.fromJson(json["item"]);
        }
      } catch (e, stackTrace) {
        print('Error parsing item for type ${parsedItemType.value}: $e');
        print('Stack trace: $stackTrace');
        parsedItem = null; // Ensure item is null on parsing failure
      }
    }

    // Create the object
    final itemsWithOffer = ItemsWithOffer._(
      id: id,
      expiredAt: expiredAt,
      discount: discount,
      discountType: discountType,
      maxDiscount: maxDiscount,
      item: parsedItem,
    );
    itemsWithOffer.itemType = parsedItemType; // Set the late final field
    return itemsWithOffer;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "expired_at": expiredAt,
    "discount": discount,
    "discount_type": discountType,
    "max_discount": maxDiscount,
    "item_type": itemType.value,
    "item": item?.toEntity(),
  };

  /// Converts ItemsWithOffer to GenericItemEntity with the offer from wrapper
  GenericItemEntity? toEntity() {
    if (item == null) return null;

    try {
      // Create an OfferDTO from the wrapper's offer data
      final offerDTO = OfferDTO(
        id: id,
        expiredAt: expiredAt,
        discount: discount?.toDouble(),
        discountType: discountType,
        maxDiscount: maxDiscount?.toInt(),
      );

      // Set the offer on the item (override any existing offer with wrapper's offer)
      item!.offer = offerDTO;

      // Convert the item to entity (which will now have the proper offer)
      final entity = item!.toEntity();
      return entity;
    } catch (e, stackTrace) {
      print('ItemsWithOffer.toEntity error for id=$id: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
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
