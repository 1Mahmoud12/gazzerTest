import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class BestPopularDto {
  final int id;
  final String title;
  final String type;
  final int? bannerId;
  final int isActive;
  final dynamic banner;
  final List<BestPopularStoreDto> data;

  BestPopularDto({
    required this.id,
    required this.title,
    required this.type,
    this.bannerId,
    required this.isActive,
    this.banner,
    required this.data,
  });

  factory BestPopularDto.fromJson(Map<String, dynamic> json) {
    return BestPopularDto(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      bannerId: json['banner_id'],
      isActive: json['is_active'] ?? 0,
      banner: json['banner'],
      data: (json['data'] as List<dynamic>?)?.map((item) => BestPopularStoreDto.fromJson(item)).toList() ?? [],
    );
  }
}

class BestPopularStoreDto {
  final String storeCategoryType;
  final int storeCategoryId;
  final int storeId;
  final String storeName;
  final String storeImage;
  final int isOpen;
  final int orderCount;
  final String rating;
  final String storeCategoryName;
  final int id;
  final String image;
  final int vendorId;
  final String address;
  final int estimatedDeliveryTime;
  final int maxDeliveryTime;
  final int minDeliveryTime;
  final String rate;
  final int rateCount;
  final int isFavorite;
  final String workFrom;
  final String workTo;
  final int is24Hours;
  final int isAlwaysClose;
  final int? closingAlertAppearBefore;
  final int totalOrders;
  final List<dynamic>? tags;
  final ProvinceZoneDto? provinceZone;

  BestPopularStoreDto({
    required this.storeCategoryType,
    required this.storeCategoryId,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.isOpen,
    required this.orderCount,
    required this.rating,
    required this.storeCategoryName,
    required this.id,
    required this.image,
    required this.vendorId,
    required this.address,
    required this.estimatedDeliveryTime,
    required this.maxDeliveryTime,
    required this.minDeliveryTime,
    required this.rate,
    required this.rateCount,
    required this.isFavorite,
    required this.workFrom,
    required this.workTo,
    required this.is24Hours,
    required this.isAlwaysClose,
    this.closingAlertAppearBefore,
    required this.totalOrders,
    this.tags,
    this.provinceZone,
  });

  factory BestPopularStoreDto.fromJson(Map<String, dynamic> json) {
    return BestPopularStoreDto(
      storeCategoryType: json['store_category_type'] ?? '',
      storeCategoryId: json['store_category_id'] ?? 0,
      storeId: json['store_id'] ?? 0,
      storeName: json['store_name'] ?? '',
      storeImage: json['store_image'] ?? '',
      isOpen: json['is_open'] ?? 0,
      orderCount: json['order_count'] ?? 0,
      rating: json['rating'] ?? '0.0',
      storeCategoryName: json['store_category_name'] ?? '',
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      vendorId: json['vendor_id'] ?? 0,
      address: json['address'] ?? '',
      estimatedDeliveryTime: json['estimated_delivery_time'] ?? 0,
      maxDeliveryTime: json['max_delivery_time'] ?? 0,
      minDeliveryTime: json['min_delivery_time'] ?? 0,
      rate: json['rate'] ?? '0.0',
      rateCount: json['rate_count'] ?? 0,
      isFavorite: json['is_favorite'] ?? 0,
      workFrom: json['work_from'] ?? '',
      workTo: json['work_to'] ?? '',
      is24Hours: json['is_24_hours'] ?? 0,
      isAlwaysClose: json['is_always_close'] ?? 0,
      closingAlertAppearBefore: json['closing_alert_appear_before'],
      totalOrders: json['total_orders'] ?? 0,
      tags: json['tags'],
      provinceZone: json['province_zone'] != null ? ProvinceZoneDto.fromJson(json['province_zone']) : null,
    );
  }

  StoreEntity toEntity() {
    return StoreEntity(
      id: id,
      name: storeName,
      storeCategoryType: storeCategoryType,
      image: image,
      parentId: storeId,
      alwaysClosed: isAlwaysClose == 1,
      isOpen: isOpen == 1,
      alwaysOpen: is24Hours == 1,
      startTime: DateTime.now(),
      estimatedDeliveryTime: estimatedDeliveryTime,
      endTime: DateTime.now(),
      rate: double.tryParse(rate) ?? 0,
      rateCount: rateCount,
      zoneName: provinceZone?.zoneName ?? '',
      isFavorite: isFavorite == 1,
      mintsBeforClosingAlert: closingAlertAppearBefore ?? -1,
      outOfStock: false,
      reviewCount: rateCount,
      totalOrders: totalOrders,
    );
  }
}

class ProvinceZoneDto {
  final int id;
  final String zoneName;

  ProvinceZoneDto({
    required this.id,
    required this.zoneName,
  });

  factory ProvinceZoneDto.fromJson(Map<String, dynamic> json) {
    return ProvinceZoneDto(
      id: json['id'] ?? 0,
      zoneName: json['zone_name'] ?? '',
    );
  }
}
