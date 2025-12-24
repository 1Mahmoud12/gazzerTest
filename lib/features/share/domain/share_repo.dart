import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/share/data/share_models.dart';

abstract class ShareRepo extends BaseApiRepo {
  ShareRepo(super.crashlyticsRepo);

  /// Generate a share link
  Future<Result<ShareGenerateResponse>> generateShareLink(ShareGenerateRequest request);

  /// Open a share link by token
  Future<Result<ShareOpenResponse>> openShareLink(String token);
}
