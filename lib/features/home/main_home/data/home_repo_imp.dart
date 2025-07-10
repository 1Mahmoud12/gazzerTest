import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/data/category_dto.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';

class HomeRepoImp extends HomeRepo {
  final ApiClient _apiClient;
  HomeRepoImp(this._apiClient);

  @override
  Future<Result<List<CategoryEntity>>> getCategories() {
    return super.call<List<CategoryEntity>>(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.storesCategories),
      parser: (respo) {
        final cats = <CategoryEntity>[];
        for (final item in respo.data['data']) {
          cats.add(CategoryDTO.fromJson(item).toCategoryEntity());
        }
        return cats;
      },
    );
  }
}
