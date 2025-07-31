import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/favorites/domain/favorite_entity.dart';

abstract class FavoriteRepo extends BaseApiRepo {
  FavoriteRepo(super.crashlyticsRepo);

  Future<Result<List<FavoriteEntity>>> getFavorites();
  Future<Result<String>> toggleFavorite(int id, FavoriteType type);
}
