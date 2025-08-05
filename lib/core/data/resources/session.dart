import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
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
  }

  final addresses = <AddressEntity>[];

  void clear() {
    _client = null;
    TokenService.deleteToken();

    /// clear cache addresses
    addresses.clear();

    /// clear cache notifications
    /// clear cache cards
    /// clear cache orders
    /// clear cache carts
  }
}
