import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/home_categories/suggested/data/dtos/suggests_dto.dart';

abstract class SuggestsRepo extends BaseApiRepo {
  SuggestsRepo(super.crashlyticsRepo);

  Future<Result<SuggestsDtoData?>> getSuggests();

  Future<SuggestsDtoData?> getCachedSuggests();
}
