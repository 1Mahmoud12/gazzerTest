import 'package:gazzer/features/home/home_categories/suggested/data/dtos/suggests_dto.dart';

abstract class SuggestsStates {}

class SuggestsInitialState extends SuggestsStates {}

class SuggestsLoadingState extends SuggestsStates {}

class SuggestsSuccessState extends SuggestsStates {
  final SuggestsDtoData? data;
  final bool isFromCache;

  SuggestsSuccessState(this.data, {this.isFromCache = false});
}

class SuggestsErrorState extends SuggestsStates {
  final String message;

  SuggestsErrorState(this.message);
}
