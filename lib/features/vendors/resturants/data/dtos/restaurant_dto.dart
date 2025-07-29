import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/category_of_plate_dto.dart';

class RestaurantDTO {
  int? id;
  String? storeName;
  String? image;
  int? storeCategoryId;
  int? vendorId;
  String? address;
  int? estimatedDeliveryTime;
  String? rate;
  int? isFavorite;
  int? isOpen;
  String? workFrom;
  String? workTo;
  int? is24Hours;
  List<String>? tags;
  String? provinceZone;

  // TODO: need to be loaded from api
  List<CategoryOfPlateDTO>? subcategories;
  double? deliveryFees;
  int? rateCount;
  String? badge;
  String? priceRange;

  RestaurantDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    image = json['image'];
    storeCategoryId = json['store_category_id'];
    vendorId = json['vendor_id'];
    address = json['address'];
    estimatedDeliveryTime = json['estimated_delivery_time'];
    rate = json['rate'];
    isFavorite = json['is_favorite'];
    isOpen = json['is_open'];
    workFrom = json['work_from'];
    workTo = json['work_to'];
    is24Hours = json['is_24_hours'];
    if (json['tags'] != null) {
      tags = [];
      for (var tag in json['tags']) {
        tags!.add(tag['name'] as String);
      }
    }
    if (json['province_zone'] is Map) {
      provinceZone = json['province_zone']['zone_name'];
    }
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

  RestaurantEntity toRestEntity() {
    return RestaurantEntity(
      id: id!,
      name: storeName!,
      image: image ?? '',
      rate: double.tryParse(rate ?? '0') ?? 0.0,
      location: provinceZone ?? '',
      address: address,
      parentId: storeCategoryId,
      categoryOfPlate: subcategories?.map((e) => e.toCategoryOfPlateEntity()).toList(),
      tag: tags,
      isFavorite: isFavorite == 1,
      isOpen: isOpen == 1,
      alwaysOpen: is24Hours == 1,
      startTime: _formDateTimeFromString(workFrom ?? ''),
      endTime: _formDateTimeFromString(workTo ?? ''),
      subCategories: subcategories?.map((e) => CategoryOfPlateEntity(id: e.id!, name: e.name ?? '', image: e.image ?? '')).toList(),
      deliveryTime: estimatedDeliveryTime != null ? '${(estimatedDeliveryTime! * 0.7).floor()} - ${(estimatedDeliveryTime! * 1.3).ceil()} ' : null,

      ///
      badge: badge,
      deliveryFees: deliveryFees ?? 0.0,
      rateCount: rateCount ?? 0,
      alwaysClosed: false, // TODO: Determine if this is needed
      priceRange: priceRange ?? '\$10 - \$20',
    );
  }
}
