import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_details_response.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_menu_response.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_of_category_response.dart';

abstract class StoresRepo extends BaseApiRepo {
  StoresRepo(super.crashlyticsRepo);

  Future<Result<StoresMenuResponse>> loadStoresMenuPage(int mainId);
  Future<Result<StoresOfCategoryResponse>> loadStoresOfCategoryPage(int mainId, int subId);
  Future<Result<StoreDetailsResponse>> loadStoreDetails(int storeId);

  Future<Result<ProductEntity>> loadProductDetails(int productId);
}
