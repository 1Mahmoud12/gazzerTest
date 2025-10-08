import 'package:gazzer/core/presentation/utils/color_utils.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/data/offer_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class ProductDTO extends GenericItemDTO {
  String? color;
  // ItemUnitBrand? itemUnitBrand;

  /// missing
  // List<String>? tags;
  // double? rate;
  // double? rateCount;
  // double? priceBeforeDiscount;

  ProductDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    name = json['name'];
    price = double.tryParse(json['app_price'].toString());
    rate = double.tryParse(json['rate'].toString());
    color = json['color'];
    offer = json['offer'] != null ? OfferDTO.fromJson(json['offer']) : null;
    description = json['description'];
    badge = json['badge'];
    image = json['image'];
    rateCount = int.tryParse(json['rate_count'].toString());
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((tag) {
        tags!.add(tag.toString());
      });
    }
  }

  @override
  ProductEntity toEntity() {
    return ProductEntity(
      id: id!,
      productId: storeId,
      name: name ?? '',
      price: double.tryParse(price.toString()) ?? 0,
      rate: double.tryParse(rate.toString()) ?? 0,
      color: ColorUtils.safeHexToColor(color),
      offer: offer?.toEntityy(),

      ///
      tags: tags,
      description: description ?? '',
      badge: badge,
      image: image ?? '',
      reviewCount: rateCount ?? 0,
      outOfStock: false,

      // priceBeforeDiscount: double.tryParse(appPrice.toString()) ?? 0,
    );
  }
}
