import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

class CategoriesWidgetDto {
  final String status;
  final String message;
  final CategoriesWidgetData? data;

  CategoriesWidgetDto({required this.status, required this.message, this.data});

  factory CategoriesWidgetDto.fromJson(Map<String, dynamic> json) {
    return CategoriesWidgetDto(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? CategoriesWidgetData.fromJson(json['data']) : null,
    );
  }
}

class CategoriesWidgetData {
  final List<CategoryEntityDto> entities;

  CategoriesWidgetData({required this.entities});

  factory CategoriesWidgetData.fromJson(Map<String, dynamic> json) {
    return CategoriesWidgetData(
      entities: (json['entities'] as List<dynamic>?)?.map((e) => CategoryEntityDto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  List<MainCategoryEntity> toEntities() {
    return entities.map((e) => e.toEntity()).toList();
  }
}

class CategoryEntityDto {
  final int id;
  final String name;
  final String type;
  final String image;

  CategoryEntityDto({required this.id, required this.name, required this.type, required this.image});

  factory CategoryEntityDto.fromJson(Map<String, dynamic> json) {
    return CategoryEntityDto(id: json['id'] ?? 0, name: json['name'] ?? '', type: json['type'] ?? '', image: json['image'] ?? '');
  }

  MainCategoryEntity toEntity() {
    return MainCategoryEntity(id: id, name: name, image: image, type: VendorType.fromString(type));
  }
}
