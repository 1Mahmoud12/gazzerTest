import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/data/dtos/suggests_dto.dart';

class SuggestsResponse {
  final SuggestsDtoData? data;
  final PaginationInfo? pagination;

  SuggestsResponse({this.data, this.pagination});
}

abstract class SuggestsRepo extends BaseApiRepo {
  SuggestsRepo(super.crashlyticsRepo);

  Future<Result<SuggestsResponse>> getSuggests({int page = 1, int perPage = 10});

  Future<SuggestsDtoData?> getCachedSuggests();
}
