import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';

class TopVendorsWidgetData {
  final List<VendorEntity> vendors;
  final BannerEntity? banner;

  TopVendorsWidgetData({required this.vendors, this.banner});
}

abstract class TopVendorsWidgetRepo extends BaseApiRepo {
  TopVendorsWidgetRepo(super.crashlyticsRepo);

  Future<Result<TopVendorsWidgetData>> getTopVendors();

  Future<TopVendorsWidgetData?> getCachedTopVendors();
}
