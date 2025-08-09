import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/search/domain/search_product_entity.dart';
import 'package:gazzer/features/vendors/common/data/offer_dto.dart';

class SearchProductDTO {
  int? id;
  String? name;
  String? price;
  String? color;
  OfferDTO? offer;

  /// missing
  String? type;
  String? image;
  double? rate;
  String? badge;

  SearchProductDTO.fromJson(Map<String, dynamic> json, ItemType? typeofParent) {
    id = json['id'];
    name = json['name'] ?? json['plate_name'] ?? 'null';
    price = json['app_price'];
    color = json['color'];
    offer = json['offer'] != null ? OfferDTO.fromJson(json['offer']) : null;
    type = json['type'] ?? json['item_type'] ?? typeofParent?.value;
    image = json['image'] ?? json['plate_image'];
    rate = double.tryParse(json['rate'].toString());
  }
  SearchProductEntity toEntity() {
    return SearchProductEntity(
      id: id!,
      name: name!,
      price: double.tryParse(price.toString()) ?? 0,
      offer: offer?.toEntityy(),
      type: ItemType.fromString(type ?? ''),
      image: image ?? '',
      rate: rate ?? 0,
      badge: badge ?? '',
    );
  }
}
