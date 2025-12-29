import 'package:gazzer/core/data/dto/banner_dto.dart';

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
  final BannerDTO? banner;

  CategoriesWidgetData({required this.entities, this.banner});

  factory CategoriesWidgetData.fromJson(Map<String, dynamic> json) {
    return CategoriesWidgetData(
      entities: (json['entities'] as List<dynamic>?)?.map((e) => CategoryEntityDto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      banner: json['banner'] != null ? BannerDTO.fromJson(json['banner'] as Map<String, dynamic>) : null,
    );
  }

  List<CategoryEntityDto> toEntities() {
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

  CategoryEntityDto toEntity() {
    return CategoryEntityDto(id: id, name: name, image: image, type: type);
  }
}
