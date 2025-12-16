import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_dto.dart';

class BestPopularStoresWidgetDto {
  final String status;
  final String message;
  final BestPopularStoresWidgetDataDto? data;

  BestPopularStoresWidgetDto({required this.status, required this.message, this.data});

  factory BestPopularStoresWidgetDto.fromJson(Map<String, dynamic> json) {
    return BestPopularStoresWidgetDto(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? BestPopularStoresWidgetDataDto.fromJson(json['data']) : null,
    );
  }
}

class BestPopularStoresWidgetDataDto {
  final List<StoreDTO> entities;
  final BannerDTO? banner;

  BestPopularStoresWidgetDataDto({required this.entities, this.banner});

  factory BestPopularStoresWidgetDataDto.fromJson(Map<String, dynamic> json) {
    return BestPopularStoresWidgetDataDto(
      entities: (json['entities'] as List<dynamic>?)?.map((e) => StoreDTO.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      banner: json['banner'] != null ? BannerDTO.fromJson(json['banner'] as Map<String, dynamic>) : null,
    );
  }

  List<GenericVendorEntity> toEntities() {
    return entities.map((e) => e.toEntity()).toList();
  }
}
