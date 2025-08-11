import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class to manage the session data.
/// It holds the current client information and data related to this app session.
class Session {
  Session._();
  static final _inst = Session._();
  factory Session() => _inst;

  bool get showTour => di<SharedPreferences>().getBool(StorageKeys.haveSeenTour) != true;

  ClientEntity? _client;
  ClientEntity? get client => _client;
  set setClient(ClientEntity? client) {
    _client = client;
    if (client == null) clear();
  }

  LatLng? tmpLocation;
  final addresses = <AddressEntity>[];

  AddressEntity? get defaultAddress => addresses.firstWhereOrNull((e) => e.isDefault);

  Future<void> loadUserData() async {
    /// cart
    /// favorite
    /// addresses
    await Future.wait([
      di<FavoriteBus>().getFavorites(),
      di<AddressesBus>().refreshAddresses(),
      di<CartBus>().loadCart(),
    ]);
  }

  void clear() {
    _client = null;
    TokenService.deleteToken();

    /// clear cache addresses
    di<AddressesBus>().clearAddresses();

    /// clear cache notifications
    di<FavoriteBus>().clearFavorites();

    /// clear cache cards
    /// clear cache orders
    /// clear cache carts
    di<CartBus>().clearCart();
  }
}
