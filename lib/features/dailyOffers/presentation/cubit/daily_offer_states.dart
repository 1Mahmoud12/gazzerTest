import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';

sealed class DailyOfferStates {}

final class DailyOfferInitialState extends DailyOfferStates {}

final class DailyOfferLoadingState extends DailyOfferStates {}

final class DailyOfferSuccessState extends DailyOfferStates {
  final DailyOfferDataModel? dailyOfferDataModel;

  DailyOfferSuccessState(this.dailyOfferDataModel);
}

final class DailyOfferErrorState extends DailyOfferStates {
  final String error;

  DailyOfferErrorState(this.error);
}
