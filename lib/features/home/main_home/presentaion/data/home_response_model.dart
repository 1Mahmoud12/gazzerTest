import 'package:gazzer/core/domain/banner_entity.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/stores/domain/store_item_entity.dart.dart';

class HomeDataModel {
  late final (List<CategoryEntity>, BannerEntity?)? categories;
  late final (List<ProductItemEntity?>, BannerEntity?)? dailyOffers;
  late final (List<ProductItemEntity?>, BannerEntity?)? suggested;
  late final (List<ProductItemEntity?>, BannerEntity?)? topItems;
  late final (List<VendorEntity?>, BannerEntity?)? topVendors;
  late final (List<ProductItemEntity?>, BannerEntity?)? bestPopular;

  HomeDataModel({
    required this.categories,
    required this.dailyOffers,
    required this.suggested,
    required this.topItems,
    required this.topVendors,
    required this.bestPopular,
  });
}
