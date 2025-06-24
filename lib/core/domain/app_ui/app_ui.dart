import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class AppUi {
  AppUi._() {
    SharedPreferences.getInstance().then((prefs) {
      _showTour = prefs.getBool(StorageKeys.haveSeenTour) != true;
    });
  }
  late final bool _showTour;
  bool get howTour => !_showTour;
}

class AppUiImpl extends AppUi {
  AppUiImpl() : super._();
}
