import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/plate_entity.dart';

abstract class PlatesRepo extends BaseApiRepo {
  Future<Result<List<PlateEntity>>> getAllPlatesPaginated(int page, [int perPage = 10]);
  Future<Result<List<PlateEntity>>> getPlatesByRest(int restId);
  Future<Result<List<PlateEntity>>> getPlatesByRestAnCatOfPlate(int restId, int catOfPlateId);
}
