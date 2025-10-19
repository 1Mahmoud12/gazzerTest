part of 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';

class StoreCategoryEntity extends GenericSubCategoryEntity {
  const StoreCategoryEntity({
    required super.id,
    required super.name,
    required super.image,
    super.style,
    super.layout,
    super.parentId,
    super.products,
  });
}
