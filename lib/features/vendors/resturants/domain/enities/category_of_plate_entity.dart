import 'package:equatable/equatable.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class CategoryOfPlateEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final int? parentId;
  final CardStyle style;
  final LayoutType layout;

  const CategoryOfPlateEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.style,
    required this.layout,
    required this.parentId,
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
