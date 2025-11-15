import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/loyaltyProgram/data/dto/loyalty_program_dto.dart';
import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';
import 'package:gazzer/features/loyaltyProgram/domain/loyalty_program_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLoyaltyProgramCache = 'loyalty_program_json';
const _kLoyaltyProgramTs = 'loyalty_program_timestamp';

class LoyaltyProgramRepoImpl extends LoyaltyProgramRepo {
  LoyaltyProgramRepoImpl(this._apiClient, super.crashlyticsRepo);

  final ApiClient _apiClient;

  @override
  Future<Result<LoyaltyProgramEntity?>> getLoyaltyProgram() async {
    final result = await super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.loyaltyProgram),
      parser: (response) {
        _saveToCache(response.data);
        final dto = LoyaltyProgramResponseDto.fromJson(response.data as Map<String, dynamic>);
        return dto.toEntity();
      },
    );

    if (result is Err<LoyaltyProgramEntity?>) {
      final cached = await getCachedLoyaltyProgram();
      if (cached != null) {
        return Result.ok(cached);
      }
    }

    return result;
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kLoyaltyProgramCache, jsonEncode(responseData));
      await sp.setInt(_kLoyaltyProgramTs, DateTime.now().millisecondsSinceEpoch);
    } catch (_) {
      // ignore cache failures
    }
  }

  @override
  Future<LoyaltyProgramEntity?> getCachedLoyaltyProgram() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(_kLoyaltyProgramCache);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final dto = LoyaltyProgramResponseDto.fromJson(map);
      return dto.toEntity();
    } catch (_) {
      return null;
    }
  }
}
