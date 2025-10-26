class SuggestsDto {
  SuggestsDto({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final SuggestsDtoData? data;

  factory SuggestsDto.fromJson(Map<String, dynamic> json) {
    return SuggestsDto(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : SuggestsDtoData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class SuggestsDtoData {
  SuggestsDtoData({
    required this.entities,
    this.banner,
  });

  final List<SuggestEntity> entities;
  final dynamic banner;

  factory SuggestsDtoData.fromJson(Map<String, dynamic> json) {
    return SuggestsDtoData(
      entities: json["entities"] == null
          ? []
          : List<SuggestEntity>.from(
              json["entities"]!.map((x) => SuggestEntity.fromJson(x)),
            ),
      banner: json["banner"],
    );
  }

  Map<String, dynamic> toJson() => {
    "entities": entities.map((x) => x.toJson()).toList(),
    "banner": banner,
  };
}

class SuggestEntity {
  SuggestEntity({
    this.id,
    this.itemType,
    this.itemId,
    this.item,
    this.storeInfo,
    this.recommendationType,
    this.score,
  });

  final String? id;
  final String? itemType;
  final int? itemId;
  final SuggestItem? item;
  final SuggestStoreInfo? storeInfo;
  final String? recommendationType;
  final int? score;

  factory SuggestEntity.fromJson(Map<String, dynamic> json) {
    return SuggestEntity(
      id: json["id"],
      itemType: json["item_type"],
      itemId: json["item_id"],
      item: json["item"] == null ? null : SuggestItem.fromJson(json["item"]),
      storeInfo: json["store_info"] == null ? null : SuggestStoreInfo.fromJson(json["store_info"]),
      recommendationType: json["recommendation_type"],
      score: json["score"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_type": itemType,
    "item_id": itemId,
    "item": item?.toJson(),
    "store_info": storeInfo?.toJson(),
    "recommendation_type": recommendationType,
    "score": score,
  };
}

class SuggestItem {
  SuggestItem({
    this.id,
    this.storeId,
    this.plateName,
    this.name,
    this.plateCategoryId,
    this.plateDescription,
    this.plateImage,
    this.image,
    this.price,
    this.rate,
    this.rateCount,
    this.appPrice,
    this.itemType,
    this.orderedWith,
    this.isFavorite,
    this.isHaveCartTimes,
    this.cartTimeQuantity,
    this.hasOptions,
    this.quantityInStock,
    this.color,
    this.offer,
    this.itemUnitBrand,
  });

  final int? id;
  final int? storeId;
  final String? plateName;
  final String? name;
  final int? plateCategoryId;
  final String? plateDescription;
  final String? plateImage;
  final String? image;
  final String? price;
  final String? rate;
  final int? rateCount;
  final String? appPrice;
  final String? itemType;
  final List<dynamic>? orderedWith;
  final int? isFavorite;
  final int? isHaveCartTimes;
  final int? cartTimeQuantity;
  final bool? hasOptions;
  final int? quantityInStock;
  final String? color;
  final SuggestOffer? offer;
  final dynamic itemUnitBrand;

  factory SuggestItem.fromJson(Map<String, dynamic> json) {
    return SuggestItem(
      id: json["id"],
      storeId: json["store_id"],
      plateName: json["plate_name"],
      name: json["name"],
      plateCategoryId: json["plate_category_id"],
      plateDescription: json["plate_description"],
      plateImage: json["plate_image"],
      image: json["image"],
      price: json["price"],
      rate: json["rate"],
      rateCount: json["rate_count"],
      appPrice: json["app_price"],
      itemType: json["item_type"],
      orderedWith: json["ordered_with"] == null ? [] : List<dynamic>.from(json["ordered_with"]!.map((x) => x)),
      isFavorite: json["is_favorite"],
      isHaveCartTimes: json["is_have_cart_times"],
      cartTimeQuantity: json["cart_time_quantity"],
      hasOptions: json["has_options"],
      quantityInStock: json["quantity_in_stock"],
      color: json["color"],
      offer: json["offer"] == null ? null : SuggestOffer.fromJson(json["offer"]),
      itemUnitBrand: json["item_unit_brand"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "plate_name": plateName,
    "name": name,
    "plate_category_id": plateCategoryId,
    "plate_description": plateDescription,
    "plate_image": plateImage,
    "image": image,
    "price": price,
    "rate": rate,
    "rate_count": rateCount,
    "app_price": appPrice,
    "item_type": itemType,
    "ordered_with": orderedWith?.map((x) => x).toList(),
    "is_favorite": isFavorite,
    "is_have_cart_times": isHaveCartTimes,
    "cart_time_quantity": cartTimeQuantity,
    "has_options": hasOptions,
    "quantity_in_stock": quantityInStock,
    "color": color,
    "offer": offer?.toJson(),
    "item_unit_brand": itemUnitBrand,
  };
}

class SuggestOffer {
  SuggestOffer({
    this.id,
    this.expiredAt,
    this.discount,
    this.discountType,
    this.maxDiscount,
  });

  final int? id;
  final String? expiredAt;
  final int? discount;
  final String? discountType;
  final int? maxDiscount;

  factory SuggestOffer.fromJson(Map<String, dynamic> json) {
    return SuggestOffer(
      id: json["id"],
      expiredAt: json["expired_at"],
      discount: json["discount"],
      discountType: json["discount_type"],
      maxDiscount: json["max_discount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "expired_at": expiredAt,
    "discount": discount,
    "discount_type": discountType,
    "max_discount": maxDiscount,
  };
}

class SuggestStoreInfo {
  SuggestStoreInfo({
    this.storeCategoryType,
    this.storeCategoryId,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.isOpen,
    this.orderCount,
    this.rating,
    this.storeCategoryName,
  });

  final String? storeCategoryType;
  final int? storeCategoryId;
  final int? storeId;
  final String? storeName;
  final String? storeImage;
  final int? isOpen;
  final int? orderCount;
  final String? rating;
  final String? storeCategoryName;

  factory SuggestStoreInfo.fromJson(Map<String, dynamic> json) {
    return SuggestStoreInfo(
      storeCategoryType: json["store_category_type"],
      storeCategoryId: json["store_category_id"],
      storeId: json["store_id"],
      storeName: json["store_name"],
      storeImage: json["store_image"],
      isOpen: json["is_open"],
      orderCount: json["order_count"],
      rating: json["rating"],
      storeCategoryName: json["store_category_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "store_category_type": storeCategoryType,
    "store_category_id": storeCategoryId,
    "store_id": storeId,
    "store_name": storeName,
    "store_image": storeImage,
    "is_open": isOpen,
    "order_count": orderCount,
    "rating": rating,
    "store_category_name": storeCategoryName,
  };
}
