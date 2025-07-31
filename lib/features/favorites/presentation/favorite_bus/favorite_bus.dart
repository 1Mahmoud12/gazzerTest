import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/favorites/domain/favorites_repo.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_events.dart';

export 'package:gazzer/core/presentation/extensions/enum.dart';

///
///
///

class FavoriteBus extends AppBus {
  FavoriteBus(this._favoriteRepo);
  final FavoritesRepo _favoriteRepo;
  final _favoriteIds = <FavoriteType, Set<int>>{};
  final _favorites = <FavoriteType, Map<int, Favorable>>{
    FavoriteType.restaurant: <int, Favorable>{},
    FavoriteType.store: <int, Favorable>{},
    FavoriteType.plate: <int, Favorable>{},
    FavoriteType.product: <int, Favorable>{},
    FavoriteType.unknown: <int, Favorable>{},
  };

  Future<void> getFavorites() async {
    fire(const GetFavoriteLoading());
    final result = await _favoriteRepo.getFavorites();
    switch (result) {
      case Ok<List<Favorable>> ok:
        _favorites.clear();
        for (final fav in ok.value) {
          _addToFavorites(fav);
        }
        print(_favorites[FavoriteType.restaurant]);
        fire(GetFavoriteSuccess(favorites: _favorites));
        break;
      case Err error:
        fire(GetFavoriteFailure(message: error.error.message, favorites: _favorites));
    }
  }

  Future<void> toggleFavorite(Favorable favorite) async {
    if (_favorites[favorite.favoriteType]?.containsKey(favorite.id) ?? false) {
      await _removeFavorite(favorite);
    } else {
      await _addFavorite(favorite);
    }
  }

  Future<void> _addFavorite(Favorable favorite) async {
    fire(ToggleFavoriteLoading(id: favorite.id, type: favorite.favoriteType, favorites: _favorites));
    final result = await _favoriteRepo.addFavorite(favorite.id, favorite.favoriteType);
    switch (result) {
      case Ok<String> _:
        _addToFavorites(favorite);
        fire(ToggleFavoriteSuccess(id: favorite.id, type: favorite.favoriteType, favorites: _favorites));
        break;
      case Err error:
        fire(ToggleFavoriteFailure(message: error.error.message, id: favorite.id, type: favorite.favoriteType, favorites: _favorites));
    }
  }

  Future<void> _removeFavorite(Favorable favorite) async {
    fire(ToggleFavoriteLoading(id: favorite.id, type: favorite.favoriteType, favorites: _favorites));
    final result = await _favoriteRepo.removeFavorite(favorite.id, favorite.favoriteType);
    switch (result) {
      case Ok<String> _:
        _removeFromFavorites(favorite);
        fire(ToggleFavoriteSuccess(id: favorite.id, type: favorite.favoriteType, favorites: _favorites));
        break;
      case Err error:
        fire(ToggleFavoriteFailure(message: error.error.message, id: favorite.id, type: favorite.favoriteType, favorites: _favorites));
    }
  }

  bool isFavorite(Favorable favorable) {
    return _favoriteIds[favorable.favoriteType]?.contains(favorable.id) ?? false;
  }

  _addToFavorites(Favorable favorable) {
    _favorites[favorable.favoriteType] ??= <int, Favorable>{};
    _favorites[favorable.favoriteType]?.addAll({favorable.id: favorable});
    _favoriteIds[favorable.favoriteType] ??= <int>{};
    _favoriteIds[favorable.favoriteType]!.add(favorable.id);
  }

  _removeFromFavorites(Favorable favorable) {
    _favorites[favorable.favoriteType]?.removeWhere((k, v) => k == favorable.id);
    _favoriteIds[favorable.favoriteType]?.remove(favorable.id);
    if (_favoriteIds[favorable.favoriteType]?.isEmpty == true) {
      _favorites.remove(favorable.favoriteType);
      _favoriteIds.remove(favorable.favoriteType);
    }
  }
}
