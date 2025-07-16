import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';

abstract class LoginRepo extends BaseApiRepo {
  LoginRepo(super.crashlyticsRepo);

  Future<Result<String>> login(String phone, String password);
}
