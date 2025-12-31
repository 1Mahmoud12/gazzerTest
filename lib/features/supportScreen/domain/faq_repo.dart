import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';

abstract class FaqRepo extends BaseApiRepo {
  FaqRepo(super.crashlyticsRepo);

  Future<Result<List<FaqCategoryEntity>>> getFaqCategories(String type, {int? orderId});

  Future<List<FaqCategoryEntity>?> getCachedFaqCategories(String type, {int? orderId});
}
