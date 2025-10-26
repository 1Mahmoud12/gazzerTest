part of 'product_item_dto.dart';

class MainCategoryDTO extends ProductItemDTO {
  late final int? id;
  late final String? name;
  late final String? image;
  late final String? type;

  MainCategoryDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }

  MainCategoryEntity toEntity() => MainCategoryEntity(
    id: id!,
    name: name!,
    image: image ?? '',
    type: VendorType.fromString(type ?? ''),
  );
}

class VendorDTO extends ProductItemDTO {
  int? id;
  String? vendorName;
  String? contactPerson;
  String? secondContactPerson;
  String? image;
  String? type;
  StoreInfo? storeInfo;

  VendorDTO({
    this.id,
    this.vendorName,
    this.contactPerson,
    this.secondContactPerson,
    this.storeInfo,
  });

  VendorDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendor_name'];
    contactPerson = json['contact_person'];
    secondContactPerson = json['second_contact_person'];
    image = json['image'];
    type = json['type'];
    storeInfo = json['store_info'] == null ? null : StoreInfo.fromJson(json['store_info']);
  }

  VendorEntity toEntity() {
    return VendorEntity(
      id: id ?? 0,
      storeId: storeInfo?.storeId ?? 0,
      name: vendorName ?? '',
      contactPerson: contactPerson,
      secondContactPerson: secondContactPerson,
      image: image ?? '',
      type: storeInfo?.storeCategoryType ?? '',
    );
  }
}

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
}
