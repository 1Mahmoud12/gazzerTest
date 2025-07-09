import 'package:gazzer/core/data/network/result_model.dart';

/// this class is an interface for verify screens, that is have different
/// implementations in register and forget password features
/// it is used to [verify] the otp code, [resend] the otp code, and [onChangePhone] phone number
/// [canChangePhone]it is also used to check if the phone number can be changed or not
abstract class VerifyRepo {
  /// data is sessionId in register repo, and phone number in forget password repo
  Future<Result<String>> verify(String otpCode, String data);

  /// data is sessionId in register repo, and phone number in forget password repo
  Future<Result<String>> resend(String data);

  Future<Result<String>> onChangePhone(String newPhone, String data);

  late final bool canChangePhone;
}
