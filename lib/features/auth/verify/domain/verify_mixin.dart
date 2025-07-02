import 'package:gazzer/core/data/network/result_model.dart';

mixin VerifyMixin {
  Future<Result<String>> verify(String otpCode);

  Future<Result<String>> resend();
}
