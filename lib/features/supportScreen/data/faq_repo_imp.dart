import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/dto/faq_dto.dart';
import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';
import 'package:gazzer/features/supportScreen/domain/faq_repo.dart';

class FaqRepoImp extends FaqRepo {
  final ApiClient _apiClient;

  FaqRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<FaqCategoryEntity>>> getFaqCategories(String type) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.faqCategories,
        queryParameters: {'type': type},
      ),
      parser: (response) {
        final categories = <FaqCategoryEntity>[];
        final data = response.data['data'] as List<dynamic>;
        for (var item in data) {
          categories.add(FaqCategoryDTO.fromJson(item as Map<String, dynamic>).toEntity());
        }
        return categories;
      },
    );
  }
}
