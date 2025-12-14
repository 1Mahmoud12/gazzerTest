import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/top_vendors/data/dtos/top_vendors_dto.dart';

class TopVendorsResponse {
  final List<VendorEntity> vendors;
  final PaginationInfo? pagination;

  TopVendorsResponse({required this.vendors, this.pagination});
}

abstract class TopVendorsRepo extends BaseApiRepo {
  TopVendorsRepo(super.crashlyticsRepo);

  Future<Result<TopVendorsResponse>> getTopVendors({
    int page = 1,
    int perPage = 10,
  });

  Future<List<VendorEntity>?> getCachedTopVendors();
}
