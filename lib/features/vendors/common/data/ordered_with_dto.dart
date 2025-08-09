import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class OrderedWithDTO {
  int? id;
  String? itemName;
  String? image;
  ({int? id, String? name})? brand;
  ({int? id, String? name})? genericUnit;
  String? price;
  // String? appPrice;
  // String? barcode;

  OrderedWithDTO({
    this.id,
    this.itemName,
    this.image,
    this.brand,
    this.genericUnit,
    this.price,
    // this.appPrice,
    // this.barcode,
  });

  OrderedWithDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    image = json['image'];
    brand = json['brand'] != null ? (id: json['brand']['id'], name: json['brand']['brand_name']?.toString()) : null;
    genericUnit = json['generic_unit'] != null
        ? (id: json['generic_unit']['id'], name: json['generic_unit']['generic_unit_name']?.toString())
        : null;
    price = json['price'];
    // appPrice = json['app_price'];
    // barcode = json['barcode'];
  }

  OrderedWithEntity toEntity() {
    return OrderedWithEntity(
      id: id ?? 0,
      name: itemName ?? '',
      image: image ?? '',
      rate: 0.0, // Assuming rate is not provided in DTO
      price: double.tryParse(price ?? '0') ?? 0.0,
      outOfStock: false,
      reviewCount: 0,
    );
  }
}
