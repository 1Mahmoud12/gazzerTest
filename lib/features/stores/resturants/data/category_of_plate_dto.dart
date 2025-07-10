import 'package:gazzer/features/stores/resturants/domain/category_of_plate_entity.dart';

class CategoryOfPlateDTO {
  int? id;
  String? name;
  String? image;
  String? type;
  String? createdAt;
  String? updatedAt;

  CategoryOfPlateDTO({this.id, this.name, this.createdAt, this.updatedAt});

  CategoryOfPlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  CategoryOfPlateEntity toSubCategoryEntity() => CategoryOfPlateEntity(id!, name!, image ?? '');
}
