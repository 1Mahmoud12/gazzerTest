import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

abstract class BestPopularRepository extends BaseApiRepo {
  BestPopularRepository(super.crashlyticsRepo);

  Future<Result<List<StoreEntity>>> getBestPopularStores();
}
