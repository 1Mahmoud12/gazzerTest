import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/dto/working_hours_dto.dart';
import 'package:gazzer/features/supportScreen/domain/entities/working_hours_entity.dart';
import 'package:gazzer/features/supportScreen/domain/working_hours_repo.dart';

class WorkingHoursRepoImp extends WorkingHoursRepo {
  final ApiClient _apiClient;

  WorkingHoursRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<WorkingHoursEntity>>> getWorkingHours() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.workingHours),
      parser: (response) {
        final data = response.data['data'] as List<dynamic>;
        return data
            .map(
              (item) => WorkingHoursDTO.fromJson(
                item as Map<String, dynamic>,
              ).toEntity(),
            )
            .toList();
      },
    );
  }
}
