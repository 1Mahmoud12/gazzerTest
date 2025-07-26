import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';

class CategoryOfPlateDTO {
  int? id;
  int? parentId;
  String? name;
  String? image;
  String? cardStyle;
  String? layout;

  CategoryOfPlateDTO({
    this.id,
    this.name,
    this.image,
    this.cardStyle,
    this.layout,
    this.parentId,
  });

  CategoryOfPlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    cardStyle = json['card_style'];
    layout = json['layout'];
    parentId = json['parent_id'];
  }

  CategoryOfPlateEntity toCategoryOfPlateEntity() => CategoryOfPlateEntity(
    id: id!,
    name: name!,
    image: image!,
    style: CardStyle.fromString(cardStyle ?? ''),
    parentId: parentId,
    layout: LayoutType.fromString(layout ?? ''),
  );
}
