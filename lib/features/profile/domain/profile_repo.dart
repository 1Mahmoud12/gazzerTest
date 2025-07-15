import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';

abstract class ProfileRepo extends BaseApiRepo {
  Future<Result<ClientEntity>> getClient();
  Future<Result<ClientEntity>> verifyOtp(ClientEntity client);
  Future<Result<(ClientEntity, String sessionId)>> updateClient(ClientEntity client);
  Future<Result<String>> changePassword(ClientEntity client);
  Future<Result<String>> refreshToken();
}
