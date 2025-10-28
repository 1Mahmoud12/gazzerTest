import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_details_response.dart';

abstract class PlatesRepo extends BaseApiRepo {
  PlatesRepo(super.crashlyticsRepo);

  Future<Result<List<OrderedWithEntity>>> getPlateOrderedWith(
    int restId,
    int plateId, {
    CancelToken? cancelToken,
  });

  Future<Result<List<PlateEntity>>> getAllPlatesPaginated(
    int page, [
    int perPage = 10,
  ]);
  Future<Result<List<PlateEntity>>> getPlatesByRest(int restId);

  Future<Result<List<PlateEntity>>> getPlatesByRestAnCatOfPlate(
    int restId,
    int catOfPlateId,
  );
  Future<Result<PlateDetailsResponse>> getPlateDetails(int plateId);
}
