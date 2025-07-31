import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/favorites/data/favorite_dto.dart';
import 'package:gazzer/features/favorites/domain/favorite_entity.dart';
import 'package:gazzer/features/favorites/domain/favorite_repo.dart';

class FavoritesRepoImp extends FavoriteRepo {
  final ApiClient _apiClient;
  FavoritesRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<FavoriteEntity>>> getFavorites() async {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.favorites),
      parser: (response) {
        return (response as List).map((e) => FavoriteDto.fromJson(e).toEntity()).toList();
      },
    );
  }

  @override
  Future<Result<String>> toggleFavorite(int id, FavoriteType type) async {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.toggleFavorites,
        requestBody: {'id': id, 'type': type.type},
      ),
      parser: (response) => response.data['message'] as String,
    );
  }
}
