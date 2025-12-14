import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';

sealed class DailyOfferStates {}

final class DailyOfferInitialState extends DailyOfferStates {}

final class DailyOfferLoadingState extends DailyOfferStates {}

final class DailyOfferLoadingMoreState extends DailyOfferStates {
  final DailyOfferDataModel? dailyOfferDataModel;
  final PaginationInfo? pagination;

  DailyOfferLoadingMoreState(this.dailyOfferDataModel, this.pagination);
}

final class DailyOfferSuccessState extends DailyOfferStates {
  final DailyOfferDataModel? dailyOfferDataModel;
  final PaginationInfo? pagination;
  final bool isFromCache;

  DailyOfferSuccessState(this.dailyOfferDataModel, {this.pagination, this.isFromCache = false});
}

final class DailyOfferErrorState extends DailyOfferStates {
  final String error;

  DailyOfferErrorState(this.error);
}
