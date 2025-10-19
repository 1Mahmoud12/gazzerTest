import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class StoreCategoryDto {
  int? id;
  int? parentId;
  String? name;
  String? image;
  String? cardStyle;
  String? layout;
  List<ProductEntity>? products;

  StoreCategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? json['category_name'];
    image = json['image'];
    cardStyle = json['card_style'];
    layout = json['layout'];
    parentId = json['parent_id'];
    products = json['items'] == null
        ? []
        : List<ProductEntity>.from(
            json['items'].map(
              (x) => ProductDTO.fromJson(x as Map<String, dynamic>).toEntity(),
            ),
          );
  }

  StoreCategoryEntity toEntity() => StoreCategoryEntity(
    id: id!,
    name: name!,
    image: image!,
    parentId: parentId,
    style: CardStyle.fromString(cardStyle ?? ''),
    layout: LayoutType.fromString(layout ?? ''),
    products: products,
  );
}
