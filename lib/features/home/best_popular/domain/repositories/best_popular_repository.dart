import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class BestPopularResponse {
  final List<StoreEntity> stores;
  final PaginationInfo? pagination;

  BestPopularResponse({required this.stores, this.pagination});
}

abstract class BestPopularRepository extends BaseApiRepo {
  BestPopularRepository(super.crashlyticsRepo);

  Future<Result<BestPopularResponse>> getBestPopularStores({
    int page = 1,
    int perPage = 10,
  });

  Future<List<StoreEntity>?> getCachedBestPopularStores();
}
