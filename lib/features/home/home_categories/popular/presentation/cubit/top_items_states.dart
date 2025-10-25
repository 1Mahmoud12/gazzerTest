import 'package:gazzer/features/home/home_categories/popular/data/dtos/top_items_dto.dart';

abstract class TopItemsStates {}

class TopItemsInitialState extends TopItemsStates {}

class TopItemsLoadingState extends TopItemsStates {}

class TopItemsSuccessState extends TopItemsStates {
  final TopItemsDtoData? data;
  final bool isFromCache;

  TopItemsSuccessState(this.data, {this.isFromCache = false});
}

class TopItemsErrorState extends TopItemsStates {
  final String message;

  TopItemsErrorState(this.message);
}
