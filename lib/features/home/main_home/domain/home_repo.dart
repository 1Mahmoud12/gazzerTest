import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/home/main_home/presentaion/data/home_response_model.dart';

abstract class HomeRepo extends BaseApiRepo {
  HomeRepo(super.crashlyticsRepo);

  Future<Result<List<CategoryEntity>>> getCategories();
  Future<Result<HomeDataModel>> getHome();
}
