import 'package:flutter/foundation.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/di.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralService {
  static final ReferralService _instance = ReferralService._internal();

  factory ReferralService() => _instance;

  ReferralService._internal();

  final ApiClient _apiClient = ApiClient();
  static const String _hasCheckedReferralKey = 'has_checked_referral_code';

  /// Check for referral code on first app launch
  /// Returns the referral code if found, null otherwise
  Future<String?> checkReferralCodeOnFirstLaunch() async {
    final prefs = di<SharedPreferences>();

    // Check if we've already checked for referral code
    final hasChecked = prefs.getBool(_hasCheckedReferralKey) ?? false;
    if (hasChecked) {
      debugPrint('Referral code already checked, skipping...');
      return null;
    }

    try {
      debugPrint('Checking for referral code on first launch...');

      final response = await _apiClient.get(
        endpoint: Endpoints.getReferralByDevice,
      );

      // Mark as checked regardless of result
      await prefs.setBool(_hasCheckedReferralKey, true);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        if (data != null) {
          // Check for 'referral_code' or 'ref' key
          final referralCode = data['referral_code'] ?? data['ref'];

          if (referralCode != null && referralCode.toString().isNotEmpty) {
            debugPrint('Referral code found: $referralCode');
            return referralCode.toString();
          }
        }
      }

      debugPrint('No referral code found in response');
      return null;
    } catch (e) {
      debugPrint('Error checking referral code: $e');
      // Mark as checked even on error to avoid retrying indefinitely
      await prefs.setBool(_hasCheckedReferralKey, true);
      return null;
    }
  }

  /// Navigate to register screen with referral code
  void navigateToRegisterWithReferralCode(String referralCode) {
    final context = AppNavigator.mainKey.currentContext;
    if (context != null) {
      debugPrint(
        'Navigating to register screen with referral code: $referralCode',
      );
      // Use query parameter so RegisterScreen can read it
      context.go('/register?ref=$referralCode');
    } else {
      debugPrint('Context not available for navigation');
    }
  }

  /// Reset the check flag (useful for testing or if you want to check again)
  Future<void> resetCheckFlag() async {
    final prefs = di<SharedPreferences>();
    await prefs.remove(_hasCheckedReferralKey);
  }
}
