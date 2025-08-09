import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/home/main_home/data/product_item_dto.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_category_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_dto.dart';

class StoresMenuResponse {
  late final MainCategoryEntity mainCategory;
  late final List<BannerEntity> banners;
  late final List<(StoreCategoryEntity, List<StoreEntity>)> categoryWzStores;

  StoresMenuResponse.fromJson(Map<String, dynamic> json) {
    mainCategory = MainCategoryDTO.fromJson(json['store_category']).toEntity();
    banners = [];
    if (json['banners'] != null) {
      for (var banner in json['banners']) {
        banners.add(BannerDTO.fromJson(banner).toEntity());
      }
    }
    categoryWzStores = [];
    for (var item in json['item_categories'] as List) {
      final storeCategory = StoreCategoryDto.fromJson(item);
      final stores = (item['stores'] as List).map((store) => StoreDTO.fromJson(store).toEntity()).toList();
      stores.sort((a, b) => a.isClosed ? 1 : -1);
      categoryWzStores.add((storeCategory.toEntity(), stores));
    }
  }
}
