import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';

abstract class TopVendorsRepo extends BaseApiRepo {
  TopVendorsRepo(super.crashlyticsRepo);

  Future<Result<List<VendorEntity>>> getTopVendors();

  Future<List<VendorEntity>?> getCachedTopVendors();
}
