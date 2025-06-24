import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Session._();
  static final _inst = Session._();
  factory Session() => _inst;

  final _showTour = di<SharedPreferences>().getBool(StorageKeys.haveSeenTour) != true;
  bool get showTour {
    if (_showTour) di<SharedPreferences>().setBool(StorageKeys.haveSeenTour, true);

    return _showTour;
  }
}
