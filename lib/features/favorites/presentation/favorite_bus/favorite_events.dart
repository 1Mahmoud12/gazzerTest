import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

sealed class FavoriteEvents extends AppEvent {
  final Map<FavoriteType, Map<int, Favorable>> favorites;
  const FavoriteEvents({this.favorites = const {FavoriteType.unknown: {}}});
}

sealed class GetFavoritesEvent extends FavoriteEvents {
  const GetFavoritesEvent({super.favorites});
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
  final int id;
  final FavoriteType type;
  const ToggleFavoriteStates({required this.id, required this.type, required super.favorites});
}

class ToggleFavoriteLoading extends ToggleFavoriteStates {
  const ToggleFavoriteLoading({required super.id, required super.type, required super.favorites});
}

class AddedFavoriteSuccess extends ToggleFavoriteStates {
  const AddedFavoriteSuccess({required super.id, required super.type, required super.favorites});
}
class RemovedFavoriteSuccess extends ToggleFavoriteStates {
  const RemovedFavoriteSuccess({required super.id, required super.type, required super.favorites});
}

class ToggleFavoriteFailure extends ToggleFavoriteStates {
  final String message;
  const ToggleFavoriteFailure({
    required super.id,
    required this.message,
    required super.type,
    required super.favorites,
  });
}
