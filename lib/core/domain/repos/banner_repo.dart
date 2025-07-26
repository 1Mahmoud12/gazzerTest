import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';

abstract class BannerRepo extends BaseApiRepo {
  BannerRepo(super.crashlyticsRepo);

  Future<Result<List<BannerEntity>>> getRestaurantPageBanners();
  Future<Result<List<BannerEntity>>> getStoreCategoryBanners(int cateId);
}
