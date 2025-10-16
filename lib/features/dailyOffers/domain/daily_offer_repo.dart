import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';

abstract class DailyOfferRepo extends BaseApiRepo {
  DailyOfferRepo(super.crashlyticsRepo);

  Future<Result<DailyOfferDataModel?>> getAllDailyOffer();

  Future<DailyOfferDataModel?> getCachedDailyOffer();
}
