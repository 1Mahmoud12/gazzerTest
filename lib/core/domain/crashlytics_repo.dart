abstract class CrashlyticsRepo {
  Future<void> sendToCrashlytics(Object error, StackTrace? stack, {bool isFatal = true, String? reason});
}
