import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/crashlytics_repo_imp.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([CrashlyticsRepoImp, ApiClient, SharedPreferences])
void main() {
  // This will generate the mocks
  return;
}
