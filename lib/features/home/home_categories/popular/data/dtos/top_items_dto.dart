class TopItemsDto {
  TopItemsDto({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final TopItemsDtoData? data;

  factory TopItemsDto.fromJson(Map<String, dynamic> json) {
    return TopItemsDto(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : TopItemsDtoData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class TopItemsDtoData {
  TopItemsDtoData({
    required this.entities,
    required this.banner,
  });

  final List<TopItemEntity> entities;
  final dynamic banner;

  factory TopItemsDtoData.fromJson(Map<String, dynamic> json) {
    return TopItemsDtoData(
      entities: json["entities"] == null
          ? []
          : List<TopItemEntity>.from(
              json["entities"]!.map((x) => TopItemEntity.fromJson(x)),
            ),
      banner: json["banner"],
    );
  }

  Map<String, dynamic> toJson() => {
    "entities": entities.map((x) => x.toJson()).toList(),
    "banner": banner,
  };
}

class TopItemEntity {
  TopItemEntity({
    required this.itemType,
    required this.item,
  });

  final String? itemType;
  final TopItemData? item;

  factory TopItemEntity.fromJson(Map<String, dynamic> json) {
    return TopItemEntity(
      itemType: json["item_type"],
      item: json["item"] == null ? null : TopItemData.fromJson(json["item"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "item_type": itemType,
    "item": item?.toJson(),
  };
}

class TopItemData {
  TopItemData({
    required this.id,
    required this.storeId,
    required this.plateName,
    required this.plateCategoryId,
    required this.plateDescription,
    required this.plateImage,
    required this.price,
    required this.rate,
    required this.rateCount,
    required this.appPrice,
    required this.itemType,
    required this.orderedWith,
    required this.offer,
    required this.isFavorite,
    required this.isHaveCartTimes,
    required this.cartTimeQuantity,
    required this.hasOptions,
    required this.storeInfo,
  });

  final int? id;
  final int? storeId;
  final String? plateName;
  final int? plateCategoryId;
  final String? plateDescription;
  final String? plateImage;
  final String? price;
  final String? rate;
  final int? rateCount;
  final String? appPrice;
  final String? itemType;
  final List<dynamic> orderedWith;
  final dynamic offer;
  final int? isFavorite;
  final int? isHaveCartTimes;
  final int? cartTimeQuantity;
  final bool? hasOptions;
  final TopItemStoreInfo? storeInfo;

  factory TopItemData.fromJson(Map<String, dynamic> json) {
    return TopItemData(
      id: json["id"],
      storeId: json["store_id"],
      plateName: json["plate_name"],
      plateCategoryId: json["plate_category_id"],
      plateDescription: json["plate_description"],
      plateImage: json["plate_image"],
      price: json["price"],
      rate: json["rate"],
      rateCount: json["rate_count"],
      appPrice: json["app_price"],
      itemType: json["item_type"],
      orderedWith: json["ordered_with"] == null ? [] : List<dynamic>.from(json["ordered_with"]!.map((x) => x)),
      offer: json["offer"],
      isFavorite: json["is_favorite"],
      isHaveCartTimes: json["is_have_cart_times"],
      cartTimeQuantity: json["cart_time_quantity"],
      hasOptions: json["has_options"],
      storeInfo: json["store_info"] == null ? null : TopItemStoreInfo.fromJson(json["store_info"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "plate_name": plateName,
    "plate_category_id": plateCategoryId,
    "plate_description": plateDescription,
    "plate_image": plateImage,
    "price": price,
    "rate": rate,
    "rate_count": rateCount,
    "app_price": appPrice,
    "item_type": itemType,
    "ordered_with": orderedWith.map((x) => x).toList(),
    "offer": offer,
    "is_favorite": isFavorite,
    "is_have_cart_times": isHaveCartTimes,
    "cart_time_quantity": cartTimeQuantity,
    "has_options": hasOptions,
    "store_info": storeInfo?.toJson(),
  };
}

class TopItemStoreInfo {
  TopItemStoreInfo({
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
  final int? isOpen;

  factory TopItemStoreInfo.fromJson(Map<String, dynamic> json) {
    return TopItemStoreInfo(
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
