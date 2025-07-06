import 'package:gazzer/core/data/network/result_model.dart';

abstract class VerifyRepo {
  Future<Result<String>> verify(String otpCode);

  Future<Result<String>> resend();

  Future<Result<String>> onChangePhone(String newPhone);

  late final bool canChangePhone;
}
