import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';
import 'package:gazzer/features/dailyOffers/domain/daily_offer_repo.dart';

class DailyOfferRepoImp extends DailyOfferRepo {
  final ApiClient _apiClient;

  DailyOfferRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<DailyOfferDataModel?>> getAllDailyOffer() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.getAllOffers),
      parser: (response) {
        final dto = DailyOffersDto.fromJson(response.data);
        return dto.data?.data;
      },
    );
  }
}
