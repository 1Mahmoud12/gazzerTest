import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

abstract class FavoritesRepo extends BaseApiRepo {
  FavoritesRepo(super.crashlyticsRepo);

  Future<Result<List<Favorable>>> getFavorites();
  Future<Result<String>> addFavorite(int id, FavoriteType type, {CancelToken? cancelToken});
  Future<Result<String>> removeFavorite(int id, FavoriteType type, {CancelToken? cancelToken});
}
