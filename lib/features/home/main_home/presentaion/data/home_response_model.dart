import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class HomeDataModel {
  late final List<CategoryEntity>? categories;
  late final BannerEntity? categoriesBanner;
  late final List<GenericItemEntity?>? dailyOffers;
  late final BannerEntity? dailyOffersBanner;

  late final List<GenericItemEntity?>? suggested;
  late final BannerEntity? suggestedBanner;

  late final List<GenericItemEntity?>? topItems;
  late final BannerEntity? topItemsBanner;

  late final List<VendorEntity?>? topVendors;
  late final BannerEntity? topVendorsBanner;

  late final List<GenericItemEntity?>? bestPopular;
  late final BannerEntity? bestPopularBanner;

  HomeDataModel({
    required this.categories,
    required this.dailyOffers,
    required this.suggested,
    required this.topItems,
    required this.topVendors,
    required this.bestPopular,
    this.categoriesBanner,
    this.dailyOffersBanner,
    this.suggestedBanner,
    this.topItemsBanner,
    this.topVendorsBanner,
    this.bestPopularBanner,
  });
}
