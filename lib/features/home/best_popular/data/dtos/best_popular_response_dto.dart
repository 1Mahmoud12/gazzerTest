import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class BestPopularResponseDto {
  final String? status;
  final String? message;
  final BestPopularDataDto? data;
  final PaginationInfo? pagination;

  BestPopularResponseDto({this.status, this.message, this.data, this.pagination});

  factory BestPopularResponseDto.fromJson(Map<String, dynamic> json) {
    return BestPopularResponseDto(
      status: json['status'],
      message: json['message'],
      data: json['data'] == null ? null : BestPopularDataDto.fromJson(json['data']),
      pagination: json['pagination'] == null ? null : PaginationInfo.fromJson(json['pagination']),
    );
  }
}

class BestPopularDataDto {
  final List<BestPopularStoreDto>? entities;
  final dynamic banner;

  BestPopularDataDto({this.entities, this.banner});

  factory BestPopularDataDto.fromJson(Map<String, dynamic> json) {
    return BestPopularDataDto(
      entities: json['entities'] == null ? null : (json['entities'] as List).map((e) => BestPopularStoreDto.fromJson(e)).toList(),
      banner: json['banner'],
    );
  }
}

class BestPopularStoreDto {
  final String? storeCategoryType;
  final int? storeCategoryId;
  final int? storeId;
  final String? storeName;
  final String? storeImage;
  final int? isOpen;
  final int? orderCount;
  final String? rating;
  final String? storeCategoryName;
  final int? id;
  final String? image;
  final int? vendorId;
  final String? address;
  final int? estimatedDeliveryTime;
  final int? maxDeliveryTime;
  final int? minDeliveryTime;
  final String? rate;
  final int? rateCount;
  final int? isFavorite;
  final String? workFrom;
  final String? workTo;
  final int? is24Hours;
  final int? isAlwaysClose;
  final int? closingAlertAppearBefore;
  final int? totalOrders;
  final List<String>? tags;
  final ProvinceZoneDto? provinceZone;

  BestPopularStoreDto({
    this.storeCategoryType,
    this.storeCategoryId,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.isOpen,
    this.orderCount,
    this.rating,
    this.storeCategoryName,
    this.id,
    this.image,
    this.vendorId,
    this.address,
    this.estimatedDeliveryTime,
    this.maxDeliveryTime,
    this.minDeliveryTime,
    this.rate,
    this.rateCount,
    this.isFavorite,
    this.workFrom,
    this.workTo,
    this.is24Hours,
    this.isAlwaysClose,
    this.closingAlertAppearBefore,
    this.totalOrders,
    this.tags,
    this.provinceZone,
  });

  factory BestPopularStoreDto.fromJson(Map<String, dynamic> json) {
    return BestPopularStoreDto(
      storeCategoryType: json['store_category_type'],
      storeCategoryId: json['store_category_id'],
      storeId: json['store_id'],
      storeName: json['store_name'],
      storeImage: json['store_image'] ?? json['image'],
      isOpen: json['is_open'],
      orderCount: json['order_count'] ?? json['total_orders'],
      rating: json['rating'] ?? json['rate'],
      storeCategoryName: json['store_category_name'] ?? '',
      id: json['id'] ?? 0,
      image: json['image'],
      vendorId: json['vendor_id'] ?? 0,
      address: json['address'] ?? '',
      estimatedDeliveryTime: json['estimated_delivery_time'],
      maxDeliveryTime: json['max_delivery_time'],
      minDeliveryTime: json['min_delivery_time'],
      rate: json['rate'],
      rateCount: json['rate_count'],
      isFavorite: json['is_favorite'],
      workFrom: json['work_from'] ?? '',
      workTo: json['work_to'] ?? '',
      is24Hours: json['is_24_hours'],
      isAlwaysClose: json['is_always_close'],
      closingAlertAppearBefore: json['closing_alert_appear_before'],
      totalOrders: json['total_orders'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      provinceZone: json['province_zone'] != null ? ProvinceZoneDto.fromJson(json['province_zone']) : null,
    );
  }

  StoreEntity toEntity() {
    return StoreEntity(
      id: id ?? 0,
      name: storeName ?? '',
      hasOptions: false,
      estimatedDeliveryTime: estimatedDeliveryTime ?? 0,
      image: image ?? '',
      rate: double.tryParse(rating ?? '0') ?? 0.0,
      startTime: DateTime.tryParse(workFrom ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(workTo ?? '') ?? DateTime.now(),
      zoneName: provinceZone?.zoneName ?? '',
      parentId: storeCategoryId ?? 0,
      alwaysOpen: (is24Hours ?? 0) == 1,
      alwaysClosed: (isAlwaysClose ?? 0) == 1,
      isFavorite: (isFavorite ?? 0) == 1,
      isOpen: (isOpen ?? 0) == 1,
      mintsBeforClosingAlert: closingAlertAppearBefore ?? 0,
      outOfStock: false,
      // Default value
      reviewCount: rateCount ?? 0,
      totalOrders: totalOrders ?? 0,
      storeCategoryType: storeCategoryType ?? '',
    );
  }
}

class ProvinceZoneDto {
  final int? id;
  final String? zoneName;

  ProvinceZoneDto({this.id, this.zoneName});

  factory ProvinceZoneDto.fromJson(Map<String, dynamic> json) {
    return ProvinceZoneDto(id: json['id'], zoneName: json['zone_name']);
  }
}
