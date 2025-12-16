class StoreInfo {
  StoreInfo({
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

  factory StoreInfo.fromJson(Map<String, dynamic> json) {
    return StoreInfo(
      storeCategoryType: json['store_category_type'],
      storeCategoryId: json['store_category_id'],
      storeId: json['store_id'],
      storeName: json['store_name'],
      storeImage: json['store_image'],
      isOpen: json['is_open'],
      orderCount: json['order_count'],
      rating: json['rating'],
      storeCategoryName: json['store_category_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'store_category_type': storeCategoryType,
    'store_category_id': storeCategoryId,
    'store_id': storeId,
    'store_name': storeName,
    'store_image': storeImage,
    'is_open': isOpen,
    'order_count': orderCount,
    'rating': rating,
    'store_category_name': storeCategoryName,
  };
}
