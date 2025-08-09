import 'package:gazzer/features/vendors/common/data/ordered_with_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class ProductDetailsResponse {
  late final ProductEntity product;
  late final List<OrderedWithEntity> orderedWith;
  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    product = ProductDTO.fromJson(json['item']).toEntity();
    orderedWith = (json['also_like'] as List).map((item) => OrderedWithDTO.fromJson(item).toEntity()).toList();
  }
}
