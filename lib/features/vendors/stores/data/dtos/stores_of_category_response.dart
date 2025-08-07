import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/generic_item_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_category_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_dto.dart';

class StoresOfCategoryResponse {
  late final List<ProductEntity> todaysDeals;
  late final List<StoreEntity> stores;
  late final StoreCategoryEntity subCategory;
  StoresOfCategoryResponse.fromJson(Map<String, dynamic> json) {
    todaysDeals = (json['items'] as List).map((e) => ProductDTO.fromJson(e).toEntity()).toList();
    stores = (json['stores'] as List).map((e) => StoreDTO.fromJson(e).toEntity()).toList();
    stores.sort((a, b) => a.isClosed ? 1 : -1);
    subCategory = StoreCategoryDto.fromJson(json['item_category']).toEntity();
  }
}
