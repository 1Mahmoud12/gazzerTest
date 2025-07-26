import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:gazzer/core/domain/repos/crashlytics_repo.dart';

class CrashlyticsRepoImp implements CrashlyticsRepo {
  @override
  Future<void> sendToCrashlytics(Object error, StackTrace? stack, {bool isFatal = true, String? reason}) {
    return FirebaseCrashlytics.instance.recordError(error, stack, fatal: isFatal, reason: reason);
  }
}
