import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

abstract class CategoriesWidgetRepo extends BaseApiRepo {
  CategoriesWidgetRepo(super.crashlyticsRepo);

  Future<Result<List<MainCategoryEntity>>> getCategories();

  Future<List<MainCategoryEntity>?> getCachedCategories();
}
