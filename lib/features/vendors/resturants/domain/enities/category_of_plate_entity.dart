part of 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';

class CategoryOfPlateEntity extends GenericSubCategoryEntity {
  const CategoryOfPlateEntity({
    required super.id,
    required super.name,
    required super.image,
    super.style,
    super.layout,
    super.parentId,
  });

  CategoryOfPlateEntity copyWith({
    int? id,
    String? name,
    String? image,
    int? parentId,
    CardStyle? style,
    List<GenericVendorEntity>? vendors,
    LayoutType? layout = LayoutType.grid,
  }) {
    return CategoryOfPlateEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      parentId: parentId ?? this.parentId,
      style: style ?? this.style,

      layout: layout ?? this.layout,
    );
  }

  @override
  List<Object?> get props => [id, name, image, parentId, style, layout];
}
