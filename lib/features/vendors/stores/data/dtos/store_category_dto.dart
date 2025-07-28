import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entityy.dart';

class StoreCategoryDto {
  int? id;
  int? parentId;
  String? name;
  String? image;
  String? cardStyle;
  String? layout;

  StoreCategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    cardStyle = json['card_style'];
    layout = json['layout'];
    parentId = json['parent_id'];
  }

  StoreCategoryEntity toEntity() => StoreCategoryEntity(
    id: id!,
    name: name!,
    image: image!,
    parentId: parentId,
    style: CardStyle.fromString(cardStyle ?? ''),
    layout: LayoutType.fromString(layout ?? ''),
  );
}
