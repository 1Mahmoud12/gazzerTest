import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/requests/faq_rating_request.dart';

abstract class FaqRatingRepo extends BaseApiRepo {
  FaqRatingRepo(super.crashlyticsRepo);

  Future<Result<String>> submitRating(FaqRatingRequest request);
}
