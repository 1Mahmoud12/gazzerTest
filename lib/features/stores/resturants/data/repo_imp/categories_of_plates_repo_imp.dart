import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/data/dtos/category_of_plate_dto.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/repos/categories_of_plates_repo.dart';

class CategoriesOfPlatesRepoImp extends CategoriesOfPlatesRepo {
  final ApiClient _apiClient;
  CategoriesOfPlatesRepoImp(this._apiClient);

  @override
  Future<Result<List<CategoryOfPlateEntity>>> getAllCategoriesOfPlates() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.categoriesOfPlates),
      parser: (response) {
        final data = <CategoryOfPlateEntity>[];
        for (var item in response.data['data']) {
          data.add(CategoryOfPlateDTO.fromJson(item).toCategoryOfPlateEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<CategoryOfPlateEntity>>> getCategoriesOfPlatesByRestaurant(int restaurantId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.categoryOfPlatesByRest(restaurantId)),
      parser: (response) {
        final data = <CategoryOfPlateEntity>[];
        for (var item in response.data['data']) {
          data.add(CategoryOfPlateDTO.fromJson(item).toCategoryOfPlateEntity());
        }
        return data;
      },
    );
  }
}
