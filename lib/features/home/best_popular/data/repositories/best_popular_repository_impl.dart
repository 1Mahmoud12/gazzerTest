import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/best_popular/data/dtos/best_popular_response_dto.dart';
import 'package:gazzer/features/home/best_popular/domain/repositories/best_popular_repository.dart';

class BestPopularRepositoryImpl extends BestPopularRepository {
  final ApiClient _apiClient;

  BestPopularRepositoryImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<VendorEntity>>> getBestPopularStores() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.bestPopularStores),
      parser: (response) {
        final dto = BestPopularResponseDto.fromJson(response.data);
        return dto.data.entities.map((e) => e.toEntity()).toList();
      },
    );
  }
}
