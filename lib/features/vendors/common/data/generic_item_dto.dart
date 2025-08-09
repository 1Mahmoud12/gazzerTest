import 'package:gazzer/features/vendors/common/data/offer_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

abstract class GenericItemDTO {
  int? id;
  int? storeId;
  int? caegoryId;
  String? name;
  String? image;
  String? description;
  double? price;
  int? quantityInStock;
  OfferDTO? offer;
  // ItemUnitBrand? itemUnitBrand;

  /// missing
  List<String>? tags;
  String? badge;
  double? rate;
  int? rateCount;
  double? priceBeforeDiscount;

  GenericItemDTO({
    this.id,
    this.storeId,
    this.caegoryId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.quantityInStock,
    this.offer,
    // this.itemUnitBrand,
    this.tags,
    this.rate,
    this.rateCount,
    this.priceBeforeDiscount,
  });
  GenericItemDTO.fromJson(Map<String, dynamic> json);
  GenericItemEntity toEntity();
}

