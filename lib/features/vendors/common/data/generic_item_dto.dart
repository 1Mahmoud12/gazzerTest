import 'package:gazzer/features/vendors/common/data/offer_dto.dart';
import 'package:gazzer/features/vendors/common/data/unit_brand_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class SimpleStoreDTO {
  int? id;
  String? name;
  String? type;
  String? image;

  SimpleStoreDTO({this.id, this.name, this.image});

  SimpleStoreDTO.fromJson(Map<String, dynamic> json) {
    id = json['store_id'];
    name = json['store_name'];
    type = json['store_category_type'];
    image = json['store_image'];
  }

  SimpleStoreEntity toEntity() {
    return SimpleStoreEntity(
      id: id ?? 0,
      name: name ?? '',
      type: type ?? '',
      image: image ?? '',
    );
  }
}

class SimpleStoreEntity {
  final int id;
  final String name;
  final String type;
  final String image;

  SimpleStoreEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
  });
}

abstract class GenericItemDTO {
  int? id;
  int? productId;
  int? storeId;
  int? caegoryId;
  String? name;
  String? image;
  String? description;
  double? price;
  int? quantityInStock;
  OfferDTO? offer;
  ItemUnitBrandDTO? itemUnitBrand;
  SimpleStoreDTO? store;
  bool? hasOptions;

  /// missing
  List<String>? tags;
  String? badge;
  double? rate;
  int? rateCount;
  double? priceBeforeDiscount;

  GenericItemDTO({
    this.id,
    this.productId,
    this.storeId,
    this.caegoryId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.quantityInStock,
    this.offer,
    this.itemUnitBrand,
    this.store,
    this.tags,
    this.rate,
    this.rateCount,
    this.priceBeforeDiscount,
    this.hasOptions,
  });
  GenericItemDTO.fromJson(Map<String, dynamic> json);
  GenericItemEntity toEntity();
}
