import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

class AllCategoriesResponse {
  final List<MainCategoryEntity> categories;
  final PaginationInfo? pagination;

  AllCategoriesResponse({required this.categories, this.pagination});
}

abstract class AllCategoriesRepo extends BaseApiRepo {
  AllCategoriesRepo(super.crashlyticsRepo);

  Future<Result<AllCategoriesResponse>> getAllCategories({
    int page = 1,
    int perPage = 20,
  });
}
