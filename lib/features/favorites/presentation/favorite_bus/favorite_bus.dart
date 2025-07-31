import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/api_command.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/features/favorites/domain/favorite_entity.dart';
import 'package:gazzer/features/favorites/domain/favorite_repo.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_events.dart';

class FavoriteBus extends AppBus {
  final FavoriteRepo _favoriteRepo;
  FavoriteBus(this._favoriteRepo);
  final restaurantsQueue = <int, ApiCommand>{};
  final storesQueue = <int, ApiCommand>{};
  final platesQueue = <int, ApiCommand>{};
  final productsQueue = <int, ApiCommand>{};
  final _favorites = <FavoriteType, List<FavoriteEntity>>{
    FavoriteType.restaurant: [],
    FavoriteType.store: [],
    FavoriteType.plate: [],
    FavoriteType.product: [],
    FavoriteType.unknown: [],
  };

  Future<void> getFavorites() async {
    fire(const GetFavoriteLoading());
    final result = await _favoriteRepo.getFavorites();
    switch (result) {
      case Ok<List<FavoriteEntity>> ok:
        _favorites.clear();
        for (final fav in ok.value) {
          _favorites.putIfAbsent(fav.type, () => []).add(fav);
        }
        fire(GetFavoriteSuccess(favorites: _favorites));
        break;
      case Err error:
        fire(GetFavoriteFailure(message: error.error.message, favorites: _favorites));
    }
  }

  Future<void> toggleFavorite(int id, FavoriteType type) async {
    final queue = _getRelatedQueue(type);
    if (queue[id] != null && queue[id]!.running && !queue[id]!.canceled) {
      // stop the existing command if it's running && remove from queue
      _stopCommandExecution(queue[id]!);
      queue.remove(id);
      return;
    }
    // ** not exists
    /// - add command to correct queue
    /// - execute command
    /// -- if success: remove command from queue after execution
    /// -- if failure: undo command && remove from queue
  }

  Map<int, ApiCommand> _getRelatedQueue(FavoriteType type) {
    switch (type) {
      case FavoriteType.restaurant:
        return restaurantsQueue;
      case FavoriteType.store:
        return storesQueue;
      case FavoriteType.plate:
        return platesQueue;
      case FavoriteType.product:
        return productsQueue;
      default:
        return {};
    }
  }

  Future<void> _stopCommandExecution(ApiCommand command) async {
    command.cancel();
    await command.unDo();
  }

  ApiCommand _createCommand(int id){
    return
  }


}
