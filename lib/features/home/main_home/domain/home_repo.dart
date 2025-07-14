import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/data/home_reponse.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

abstract class HomeRepo extends BaseApiRepo {
  Future<Result<List<CategoryEntity>>> getCategories();
  Future<Result<HomeReponse>> getHome();
}
