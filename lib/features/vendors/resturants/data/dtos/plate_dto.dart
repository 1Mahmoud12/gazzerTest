
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class PlateDTO extends GenericItemDTO {
  PlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    name = json['plate_name'];
    caegoryId = json['plate_category_id'];
    description = json['plate_description'];
    image = json['plate_image'];
    rate = double.tryParse(json['rate'].toString());
    rateCount = int.tryParse(json['rate_count'].toString());
    price = double.tryParse(json['app_price'].toString());
    badge = json['badge'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((tag) {
        tags!.add(tag.toString());
      });
    }
  }

  @override
  PlateEntity toEntity() {
    return PlateEntity(
      id: id!,
      categoryPlateId: caegoryId ?? 0,
      name: name ?? '',
      description: description ?? '',
      image: image ?? '',
      price: double.tryParse(price.toString()) ?? 0,
      rate: rate ?? 0,
      outOfStock: id?.isEven ?? false,
      badge: badge,
      reviewCount: rateCount ?? 0,
      offer: offer?.toEntityy(),
      tags: tags,
    );
  }
}
