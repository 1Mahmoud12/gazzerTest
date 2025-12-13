import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class SuggestsWidgetData {
  final List<GenericItemEntity> entities;
  final BannerEntity? banner;

  SuggestsWidgetData({required this.entities, this.banner});
}

abstract class SuggestsWidgetRepo extends BaseApiRepo {
  SuggestsWidgetRepo(super.crashlyticsRepo);

  Future<Result<SuggestsWidgetData>> getSuggests();

  Future<SuggestsWidgetData?> getCachedSuggests();
}
