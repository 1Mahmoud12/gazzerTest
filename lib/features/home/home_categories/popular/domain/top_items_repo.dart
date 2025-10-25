import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/home_categories/popular/data/dtos/top_items_dto.dart';

abstract class TopItemsRepo extends BaseApiRepo {
  TopItemsRepo(super.crashlyticsRepo);

  Future<Result<TopItemsDtoData?>> getTopItems();

  Future<TopItemsDtoData?> getCachedTopItems();
}
