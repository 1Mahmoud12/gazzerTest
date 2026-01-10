import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/favorites/data/favorite_dto.dart';
import 'package:gazzer/features/favorites/domain/favorites_repo.dart';

class FavoritesRepoImp extends FavoritesRepo {
  final ApiClient _apiClient;
  FavoritesRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<Favorable>>> getFavorites() async {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.favorites),
      parser: (response) {
        return (response.data['data'] as List).map((e) => FavoriteDto.fromJson(e).toEntity()).toList();
      },
    );
  }

  @override
  Future<Result<String>> addFavorite(int id, FavoriteType type, {CancelToken? cancelToken}) async {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.addFavorite, requestBody: {'id': id, 'type': type.type}, cancelToken: cancelToken),
      parser: (response) => response.data['message'] as String,
    );
  }

  @override
  Future<Result<String>> removeFavorite(int id, FavoriteType type, {CancelToken? cancelToken}) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.removeFavorite, requestBody: {'id': id, 'type': type.type}, cancelToken: cancelToken),
      parser: (response) => response.data['message'] as String,
    );
  }
}
