part of 'section_item_dto.dart';

class CategoryDTO extends SectionItem {
  final int? id;
  final String? name;
  final String? image;
  final String? type;

  CategoryDTO(this.id, this.name, this.image, this.type);

  CategoryDTO.fromJson(Map<String, dynamic> json) : id = json['id'], name = json['name'], type = json['type'], image = json['image'];

  CategoryEntity toCategoryEntity() => CategoryEntity(id!, name!, image ?? '', CategoryType.fromString(type ?? ''));
}
