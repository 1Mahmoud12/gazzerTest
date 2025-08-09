import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/search/data/search_query.dart';
import 'package:gazzer/features/search/data/search_response.dart';

abstract class SearchRepo extends BaseApiRepo {
  SearchRepo(super.crashlyticsRepo);

  Future<Result<SearchResponse>> search(SearchQuery query);

  Future<Result<List<MainCategoryEntity>>> getCategories();
}
