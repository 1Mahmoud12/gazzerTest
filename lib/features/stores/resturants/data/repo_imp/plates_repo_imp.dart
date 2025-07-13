import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/repos/plates_repo.dart';

class PlatesRepoImp extends PlatesRepo {
  final ApiClient _apiClient;
  PlatesRepoImp(this._apiClient);

  @override
  Future<Result<List<PlateEntity>>> getAllPlatesPaginated(int page, [int perPage = 10]) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.allRestaurants(page, perPage)),
      parser: (response) {
        final data = <PlateEntity>[];
        for (var item in response.data['data']) {
          data.add(PlateDTO.fromJson(item).toPlateEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<PlateEntity>>> getPlatesByRest(int restId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.platesByRest(restId)),
      parser: (response) {
        final data = <PlateEntity>[];
        for (var item in response.data['data']) {
          data.add(PlateDTO.fromJson(item).toPlateEntity());
        }
        return data;
      },
    );
  }

  @override
  Future<Result<List<PlateEntity>>> getPlatesByRestAnCatOfPlate(int restId, int catOfPlateId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.platesByRestAnCatOfPlate(restId, catOfPlateId)),
      parser: (response) {
        final data = <PlateEntity>[];
        for (var item in response.data['data']) {
          data.add(PlateDTO.fromJson(item).toPlateEntity());
        }
        return data;
      },
    );
  }
}
