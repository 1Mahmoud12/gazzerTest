import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/data/dtos/categories_widget_dto.dart';

abstract class CategoriesWidgetRepo extends BaseApiRepo {
  CategoriesWidgetRepo(super.crashlyticsRepo);

  Future<Result<CategoriesWidgetData>> getCategories();

  Future<CategoriesWidgetData?> getCachedCategories();
}
