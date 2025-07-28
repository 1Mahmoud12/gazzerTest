import 'package:equatable/equatable.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

part 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';
part 'package:gazzer/features/vendors/stores/domain/entities/store_category_entity.dart';

/// A generic sub-category entity for [StoreCategoryEntity] and [CategoryOfPlateEntity].
sealed class GenericSubCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final int? parentId;
  final CardStyle style;
  final LayoutType layout;

  const GenericSubCategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    this.style = CardStyle.typeOne,
    this.layout = LayoutType.vertical,
    this.parentId,
  });

  @override
  List<Object?> get props => [id, name, image, parentId, style, layout];
}
