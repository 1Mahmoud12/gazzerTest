import 'package:gazzer/features/home/home_categories/suggested/data/dtos/suggests_dto.dart';

abstract class SuggestsStates {}

class SuggestsInitialState extends SuggestsStates {}

class SuggestsLoadingState extends SuggestsStates {}

class SuggestsLoadingMoreState extends SuggestsStates {
  final SuggestsDtoData? data;
  final PaginationInfo? pagination;

  SuggestsLoadingMoreState(this.data, this.pagination);
}

class SuggestsSuccessState extends SuggestsStates {
  final SuggestsDtoData? data;
  final PaginationInfo? pagination;
  final bool isFromCache;

  SuggestsSuccessState(this.data, {this.pagination, this.isFromCache = false});
}

class SuggestsErrorState extends SuggestsStates {
  final String message;

  SuggestsErrorState(this.message);
}
