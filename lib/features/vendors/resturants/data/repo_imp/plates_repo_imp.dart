import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/data/ordered_with_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_details_response.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/plates_repo.dart';

class PlatesRepoImp extends PlatesRepo {
  final ApiClient _apiClient;
  PlatesRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<PlateEntity>>> getAllPlatesPaginated(
    int page, [
    int perPage = 10,
  ]) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.allRestaurants(page, perPage)),
      parser: (response) {
        final data = <PlateEntity>[];
        for (var item in response.data['data']) {
          data.add(PlateDTO.fromJson(item).toEntity());
        }
        data.sort((a, b) => a.outOfStock ? 1 : -1);
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
          data.add(PlateDTO.fromJson(item).toEntity());
        }
        data.sort((a, b) => a.outOfStock ? 1 : -1);

        return data;
      },
    );
  }

  @override
  Future<Result<List<PlateEntity>>> getPlatesByRestAnCatOfPlate(
    int restId,
    int catOfPlateId,
  ) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.platesOfRestaurantCategory(restId, catOfPlateId),
      ),
      parser: (response) {
        final data = <PlateEntity>[];
        for (var item in response.data['data']) {
          data.add(PlateDTO.fromJson(item).toEntity());
        }
        data.sort((a, b) => a.outOfStock ? 1 : -1);

        return data;
      },
    );
  }

  @override
  Future<Result<PlateDetailsResponse>> getPlateDetails(int plateId) {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.plateDetailsPage(plateId)),
      parser: (response) {
        return PlateDetailsResponse.fromJson(response.data);
      },
    );
  }

  @override
  Future<Result<List<OrderedWithEntity>>> getPlateOrderedWith(
    int restId,
    int plateId, {
    CancelToken? cancelToken,
  }) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.orderWith(restId, plateId),
      ),
      parser: (response) {
        return (response.data['data'] as List).map((e) => OrderedWithDTO.fromJson(e).toEntity()).toList();
      },
    );
  }
}
