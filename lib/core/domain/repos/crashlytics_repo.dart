/// This class is an interface for crashlytics repository, which is used to send errors to crashlytics.
/// it is mocked in tests.
abstract class CrashlyticsRepo {
  Future<void> sendToCrashlytics(Object error, StackTrace? stack, {bool isFatal = true, String? reason});
}
