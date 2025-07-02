import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Session._();
  static final _inst = Session._();
  factory Session() => _inst;

  ClientEntity? client;
  set setClient(ClientEntity? client) {
    this.client = client;
  }

  bool get showTour => di<SharedPreferences>().getBool(StorageKeys.haveSeenTour) != true;
}
