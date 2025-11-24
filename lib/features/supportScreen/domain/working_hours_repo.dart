import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/domain/entities/working_hours_entity.dart';

abstract class WorkingHoursRepo extends BaseApiRepo {
  WorkingHoursRepo(super.crashlyticsRepo);

  Future<Result<List<WorkingHoursEntity>>> getWorkingHours();
}
