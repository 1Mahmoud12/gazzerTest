import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';

class TopVendorsWidgetDto {
  final String status;
  final String message;
  final TopVendorsWidgetDataDto? data;

  TopVendorsWidgetDto({required this.status, required this.message, this.data});

  factory TopVendorsWidgetDto.fromJson(Map<String, dynamic> json) {
    return TopVendorsWidgetDto(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? TopVendorsWidgetDataDto.fromJson(json['data']) : null,
    );
  }
}

class TopVendorsWidgetDataDto {
  final List<TopVendorEntityDto> entities;
  final BannerDTO? banner;

  TopVendorsWidgetDataDto({required this.entities, this.banner});

  factory TopVendorsWidgetDataDto.fromJson(Map<String, dynamic> json) {
    return TopVendorsWidgetDataDto(
      entities: (json['entities'] as List<dynamic>?)?.map((e) => TopVendorEntityDto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      banner: json['banner'] != null ? BannerDTO.fromJson(json['banner'] as Map<String, dynamic>) : null,
    );
  }

  List<VendorEntity> toEntities() {
    return entities.map((e) => e.toEntity()).toList();
  }
}

class TopVendorEntityDto {
  final int id;
  final String vendorName;
  final String? contactPerson;
  final String? secondContactPerson;
  final double averageRating;
  final TopVendorStoreInfoDto storeInfo;
  final int performanceScore;

  TopVendorEntityDto({
    required this.id,
    required this.vendorName,
    this.contactPerson,
    this.secondContactPerson,
    required this.averageRating,
    required this.storeInfo,
    required this.performanceScore,
  });

  factory TopVendorEntityDto.fromJson(Map<String, dynamic> json) {
    return TopVendorEntityDto(
      id: json['id'] ?? 0,
      vendorName: json['vendor_name'] ?? '',
      contactPerson: json['contact_person'],
      secondContactPerson: json['second_contact_person'],
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      storeInfo: TopVendorStoreInfoDto.fromJson(json['store_info'] as Map<String, dynamic>),
      performanceScore: json['performance_score'] ?? 0,
    );
  }

  VendorEntity toEntity() {
    return VendorEntity(
      id: id,
      name: vendorName,
      storeId: storeInfo.storeId,
      contactPerson: contactPerson,
      secondContactPerson: secondContactPerson,
      type: storeInfo.storeCategoryType,
      totalOrders: storeInfo.orderCount,
      image: storeInfo.storeImage,
    );
  }
}

class TopVendorStoreInfoDto {
  final String storeCategoryType;
  final int storeCategoryId;
  final int storeId;
  final String storeName;
  final String storeImage;
  final int isOpen;
  final int isBusy;
  final int orderCount;
  final String rating;
  final String storeCategoryName;
  final String workFrom;
  final String workTo;
  final int estimatedDeliveryTime;

  TopVendorStoreInfoDto({
    required this.storeCategoryType,
    required this.storeCategoryId,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.isOpen,
    required this.isBusy,
    required this.orderCount,
    required this.rating,
    required this.storeCategoryName,
    required this.workFrom,
    required this.workTo,
    required this.estimatedDeliveryTime,
  });

  factory TopVendorStoreInfoDto.fromJson(Map<String, dynamic> json) {
    return TopVendorStoreInfoDto(
      storeCategoryType: json['store_category_type'] ?? '',
      storeCategoryId: json['store_category_id'] ?? 0,
      storeId: json['store_id'] ?? 0,
      storeName: json['store_name'] ?? '',
      storeImage: json['store_image'] ?? '',
      isOpen: json['is_open'] ?? 0,
      isBusy: json['is_busy'] ?? 0,
      orderCount: json['order_count'] ?? 0,
      rating: json['rating'] ?? '0',
      storeCategoryName: json['store_category_name'] ?? '',
      workFrom: json['work_from'] ?? '',
      workTo: json['work_to'] ?? '',
      estimatedDeliveryTime: json['estimated_delivery_time'] ?? 0,
    );
  }
}
