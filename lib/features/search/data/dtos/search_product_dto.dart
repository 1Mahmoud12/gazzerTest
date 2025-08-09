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
  // type
  // badge
  // rate
  // image

  SearchProductDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['app_price'];
    color = json['color'];
    offer = json['offer'] != null ? OfferDTO.fromJson(json['offer']) : null;
  }
  SearchProductEntity toEntity() {
    return SearchProductEntity(
      id: id!,
      name: name!,
      price: double.tryParse(price.toString()) ?? 0,
      offer: offer?.toEntityy(),
      image: '',
      rate: 0,
      badge: null,
      type: ItemType.fromString('type'),
    );
  }
}
