import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_category_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_dto.dart';

class StoreDetailsResponse {
  late final StoreEntity store;
  late final List<(StoreCategoryEntity, List<StoreCategoryEntity> subCats, List<ProductEntity> prods)> catsWithProds;
  late final List<ProductEntity> bestSellingItems;

  StoreDetailsResponse.fromJson(Map<String, dynamic> json) {
    store = StoreDTO.fromJson(json['store']).toEntity();
    catsWithProds = [];
    for (final item in json['item_categories'] as List) {
      final cat = StoreCategoryDto.fromJson(item).toEntity();
      final subCats = <StoreCategoryEntity>[];
      final prods = <ProductEntity>[];
      if (item['sub_categories'] != null) {
        for (final items in item['sub_categories']) {
          final subCat = StoreCategoryDto.fromJson(items).toEntity();
          subCats.add(subCat);
        }
      }
      if (item['items'] != null) {
        for (final items in item['items']) {
          final prod = ProductDTO.fromJson(items).toEntity();
          prods.add(prod);
        }
        prods.sort((a, b) => a.outOfStock ? 1 : -1);
      }
      if (subCats.isNotEmpty || prods.isNotEmpty) {
        catsWithProds.add((cat, subCats, prods));
      }
    }

    // Parse best selling items
    bestSellingItems = [];
    if (json['best_selling_items'] != null) {
      for (final item in json['best_selling_items'] as List) {
        final prod = ProductDTO.fromJson(item).toEntity();
        bestSellingItems.add(prod);
      }
    }
  }
}
