import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class TopItemsWidgetData {
  final List<GenericItemEntity> entities;
  final BannerEntity? banner;

  TopItemsWidgetData({required this.entities, this.banner});
}

abstract class TopItemsWidgetRepo extends BaseApiRepo {
  TopItemsWidgetRepo(super.crashlyticsRepo);

  Future<Result<TopItemsWidgetData>> getTopItems();

  Future<TopItemsWidgetData?> getCachedTopItems();
}
