import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class StoreDTO {
  int? id;
  String? storeName;
  String? image;
  String? storeCategoryType;
  int? storeCategoryId;
  int? vendorId;
  // String? address;
  int? estimatedDeliveryTime;
  int? totalOrders;
  String? rate;
  int? isFavorite;
  int? isOpen;
  String? workFrom;
  String? workTo;
  int? is24Hours;
  int? closingAlertAppearBefore;

  List<String>? tags;
  String? provinceZone;

  StoreDTO({
    this.id,
    this.storeName,
    this.image,
    this.totalOrders,
    this.storeCategoryId,
    this.vendorId,
    // this.address,
    this.estimatedDeliveryTime,
    this.rate,
    this.isFavorite,
    this.isOpen,
    this.workFrom,
    this.workTo,
    this.is24Hours,
    this.storeCategoryType,
  });

  StoreDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['store_id'];
    storeName = json['store_name'];
    image = json['image'];
    storeCategoryId = json['store_category_id'];
    vendorId = json['vendor_id'];
    // // address = json['address'];
    estimatedDeliveryTime = json['estimated_delivery_time'];
    rate = json['rate'];
    isFavorite = json['is_favorite'];
    isOpen = json['is_open'];
    workFrom = json['work_from'];
    totalOrders = json['totalOrders'];
    workTo = json['work_to'];
    is24Hours = json['is_24_hours'];
    closingAlertAppearBefore = int.tryParse(json['closing_alert_appear_before'].toString());

    if (json['tags'] != null) {
      tags = [];
      for (final tag in json['tags']) {
        tags!.add(tag['name'] as String);
      }
    }
    if (json['province_zone'] is Map) {
      provinceZone = json['province_zone']['zone_name'];
    }
    storeCategoryType = json['store_category_type']?.toString();
  }

  DateTime? _formDateTimeFromString(String time) {
    try {
      final now = DateTime.now();
      final parts = time.split(' ').first.split(':');
      return DateTime(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
    } catch (e) {
      return null;
    }
  }

  StoreEntity toEntity() {
    return StoreEntity(
      id: id ?? 0,
      name: storeName ?? '',
      hasOptions: false,
      estimatedDeliveryTime: estimatedDeliveryTime,
      storeCategoryType: storeCategoryType,
      image: image ?? '',
      rate: double.tryParse(rate ?? '0') ?? 0.0,
      isOpen: isOpen == 1,
      totalOrders: totalOrders,
      isFavorite: isFavorite == 1,
      alwaysOpen: is24Hours == 1,
      startTime: _formDateTimeFromString(workFrom ?? ''),
      endTime: _formDateTimeFromString(workTo ?? ''),
      parentId: storeCategoryId,
      deliveryTime: estimatedDeliveryTime != null ? Helpers.convertIntToRange(estimatedDeliveryTime!, 0.3) : null,
      outOfStock: false,
      reviewCount: 20,
      zoneName: provinceZone ?? '',
      alwaysClosed: false,

      mintsBeforClosingAlert: closingAlertAppearBefore ?? 0,
    );
  }
}
