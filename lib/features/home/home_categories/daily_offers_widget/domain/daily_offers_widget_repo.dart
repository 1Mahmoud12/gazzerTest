import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class DailyOffersWidgetData {
  final List<GenericItemEntity> entities;
  final BannerEntity? banner;

  DailyOffersWidgetData({required this.entities, this.banner});
}

abstract class DailyOffersWidgetRepo extends BaseApiRepo {
  DailyOffersWidgetRepo(super.crashlyticsRepo);

  Future<Result<DailyOffersWidgetData>> getDailyOffers();

  Future<DailyOffersWidgetData?> getCachedDailyOffers();
}
