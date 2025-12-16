import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class BestPopularStoresWidgetData {
  final List<GenericVendorEntity> stores;
  final BannerEntity? banner;

  BestPopularStoresWidgetData({required this.stores, this.banner});
}

abstract class BestPopularStoresWidgetRepo extends BaseApiRepo {
  BestPopularStoresWidgetRepo(super.crashlyticsRepo);

  Future<Result<BestPopularStoresWidgetData>> getBestPopularStores();

  Future<BestPopularStoresWidgetData?> getCachedBestPopularStores();
}
