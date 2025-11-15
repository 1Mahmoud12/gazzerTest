import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';

abstract class LoyaltyProgramRepo extends BaseApiRepo {
  LoyaltyProgramRepo(super.crashlyticsRepo);

  Future<Result<LoyaltyProgramEntity?>> getLoyaltyProgram();

  Future<LoyaltyProgramEntity?> getCachedLoyaltyProgram();
}
