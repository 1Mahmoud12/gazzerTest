import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/requests/complaint_request.dart';

class ComplaintResponse {
  final int id;
  final String message;

  ComplaintResponse({required this.id, required this.message});
}

abstract class ComplaintRepo extends BaseApiRepo {
  ComplaintRepo(super.crashlyticsRepo);

  Future<Result<ComplaintResponse>> submitComplaint(ComplaintRequest request);
}
