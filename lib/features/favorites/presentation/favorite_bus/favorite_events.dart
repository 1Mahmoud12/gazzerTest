import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/features/favorites/domain/favorite_entity.dart';

sealed class FavoriteEvents extends AppEvent {
  const FavoriteEvents();
}

sealed class GetFavoritesEvent extends FavoriteEvents {
  final Map<FavoriteType, List<FavoriteEntity>> favorites;
  const GetFavoritesEvent({this.favorites = const {FavoriteType.unknown: []}});
}

class GetFavoriteLoading extends GetFavoritesEvent {
  const GetFavoriteLoading()
    : super(
        favorites: const {
          FavoriteType.restaurant: Fakers.favorites,
          FavoriteType.store: Fakers.favorites,
          FavoriteType.product: Fakers.favorites,
          FavoriteType.plate: Fakers.favorites,
        },
      );
}

class GetFavoriteSuccess extends GetFavoritesEvent {
  const GetFavoriteSuccess({required super.favorites});
}

class GetFavoriteFailure extends GetFavoritesEvent {
  final String message;
  const GetFavoriteFailure({required this.message, required super.favorites});
}

///
///
sealed class ToggleFavoriteStates extends FavoriteEvents {
  final FavoriteEntity favorite;
  const ToggleFavoriteStates({required this.favorite});
}

class ToggleFavoriteLoading extends ToggleFavoriteStates {
  const ToggleFavoriteLoading({required super.favorite});
}

class ToggleFavoriteSuccess extends ToggleFavoriteStates {
  const ToggleFavoriteSuccess({required super.favorite});
}

class ToggleFavoriteFailure extends ToggleFavoriteStates {
  final String message;
  const ToggleFavoriteFailure({required super.favorite, required this.message});
}
