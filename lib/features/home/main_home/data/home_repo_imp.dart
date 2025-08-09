import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/data/home_response_dto.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';
import 'package:gazzer/features/home/main_home/presentaion/data/home_response_model.dart';

class HomeRepoImp extends HomeRepo {
  final ApiClient _apiClient;
  HomeRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<HomeDataModel>> getHome() {
    return super.call<HomeDataModel>(
      apiCall: () => _apiClient.get(endpoint: Endpoints.homePage),
      parser: (response) {
        return HomeResponseDTO.fromJson(response.data).toModel();
      },
    );
  }
}
