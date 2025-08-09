import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/data/product_item_dto.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/search/data/search_query.dart';
import 'package:gazzer/features/search/data/search_response.dart';
import 'package:gazzer/features/search/domain/search_repo.dart';

class SearchRepoImp extends SearchRepo {
  final ApiClient _apiClient;

  SearchRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<SearchResponse>> search(SearchQuery query) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.search(query)),
      parser: (response) {
        return SearchResponse.fromJson(response.data);
      },
    );
  }

  @override
  Future<Result<List<MainCategoryEntity>>> getCategories() {
    return super.call<List<MainCategoryEntity>>(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.storesCategories),
      parser: (respo) {
        final cats = <MainCategoryEntity>[];
        for (final item in respo.data['data']) {
          cats.add(MainCategoryDTO.fromJson(item).toEntity());
        }
        return cats;
      },
    );
  }
}
