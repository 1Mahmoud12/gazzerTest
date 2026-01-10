import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticServices {
  FirebaseAnalyticServices() {
    _firebase = FirebaseAnalytics.instance;
    _firebase.setAnalyticsCollectionEnabled(true);
  }
  FirebaseAnalyticServices._();
  static final FirebaseAnalyticServices _inst = FirebaseAnalyticServices._();
  static FirebaseAnalyticServices get inst => _inst;
  late final FirebaseAnalytics _firebase;
  Future customEvent({required String name, Map<String, Object>? map}) async {
    await _firebase.logEvent(name: name, parameters: map);
  }

  Future setUserProperty({required String name, required String value}) async {
    await _firebase.setUserProperty(name: name, value: value);
  }

  Future setScreen({required String name, String? className}) async {
    await _firebase.logScreenView(
      screenName: name,
      screenClass: className ?? 'UnSettedClass',
    );
  }
}
