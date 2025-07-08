import 'package:gazzer/core/data/network/result_model.dart';

abstract class VerifyRepo {
  Future<Result<String>> verify(String otpCode, String data);

  Future<Result<String>> resend(String data);

  Future<Result<String>> onChangePhone(String newPhone, String data);

  late final bool canChangePhone;
}
