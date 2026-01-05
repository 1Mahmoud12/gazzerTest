import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/domain/all_categories_repo.dart';
import 'package:gazzer/features/home/main_home/data/product_item_dto.dart';

class AllCategoriesRepoImpl extends AllCategoriesRepo {
  final ApiClient _apiClient;

  AllCategoriesRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<AllCategoriesResponse>> getAllCategories({int page = 1, int perPage = 20}) async {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: '${Endpoints.storesCategories}?page=$page&per_page=$perPage'),
      parser: (response) {
        final data = response.data['data'] as List<dynamic>? ?? [];
        final categories = data.map((item) => MainCategoryDTO.fromJson(item as Map<String, dynamic>).toEntity()).toList();

        PaginationInfo? pagination;
        if (response.data['pagination'] != null) {
          pagination = PaginationInfo.fromJson(response.data['pagination'] as Map<String, dynamic>);
        }

        return AllCategoriesResponse(categories: categories, pagination: pagination);
      },
    );
  }
}
