import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';

class DailyOfferResponse {
  final DailyOfferDataModel? data;
  final PaginationInfo? pagination;

  DailyOfferResponse({this.data, this.pagination});
}

abstract class DailyOfferRepo extends BaseApiRepo {
  DailyOfferRepo(super.crashlyticsRepo);

  Future<Result<DailyOfferResponse>> getAllDailyOffer({
    String? search,
    String? type,
    int page = 1,
    int perPage = 10,
  });

  Future<DailyOfferDataModel?> getCachedDailyOffer();
}
