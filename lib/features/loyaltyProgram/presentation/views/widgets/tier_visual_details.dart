import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';

class TierVisualDetails {
  const TierVisualDetails({
    required this.mainColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.logo,
    required this.bannerKey,
  });

  final Color mainColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final String logo;
  final String bannerKey;
}

class TierVisualResolver {
  static const _default = TierVisualDetails(
    mainColor: Co.purple,
    primaryTextColor: Co.white,
    secondaryTextColor: Co.lightGrey,
    logo: Assets.heroIc,
    bannerKey: 'heroBanner',
  );

  static final Map<String, TierVisualDetails> _visuals = {
    'hero': const TierVisualDetails(
      mainColor: Co.purple,
      primaryTextColor: Co.white,
      secondaryTextColor: Co.lightGrey,
      logo: Assets.heroIc,
      bannerKey: 'heroBanner',
    ),
    'winner': const TierVisualDetails(
      mainColor: Co.purple600,
      primaryTextColor: Co.white,
      secondaryTextColor: Co.lightGrey,
      logo: Assets.winnerIc,
      bannerKey: 'winnerBanner',
    ),
    'gainer': const TierVisualDetails(
      mainColor: Co.purple100,
      primaryTextColor: Colors.black,
      secondaryTextColor: Co.darkGrey,
      logo: Assets.gainerIc,
      bannerKey: 'gainerBanner',
    ),
    'saver': const TierVisualDetails(
      mainColor: Co.purple200,
      primaryTextColor: Colors.black,
      secondaryTextColor: Co.darkGrey,
      logo: Assets.silverIc,
      bannerKey: 'silverBanner',
    ),
    'silver': const TierVisualDetails(
      mainColor: Co.purple200,
      primaryTextColor: Colors.black,
      secondaryTextColor: Co.darkGrey,
      logo: Assets.silverIc,
      bannerKey: 'silverBanner',
    ),
  };

  static TierVisualDetails resolve(LoyaltyTier? tier) {
    if (tier == null) return _default;
    final key = tier.name?.toLowerCase() ?? '';
    final visual = _visuals[key];
    if (visual != null) return visual;

    // Use api color if provided, otherwise fallback to default
    final fallbackColor = _parseColor(tier.color) ?? _default.mainColor;
    return TierVisualDetails(
      mainColor: fallbackColor,
      primaryTextColor: _isColorDark(fallbackColor) ? Co.white : Colors.black,
      secondaryTextColor: _isColorDark(fallbackColor) ? Co.lightGrey : Co.darkGrey,
      logo: Assets.heroIc,
      bannerKey: 'heroBanner',
    );
  }

  static Color? _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return null;
    final sanitized = hexColor.replaceAll('#', '');
    if (sanitized.length == 6) {
      return Color(int.parse('FF$sanitized', radix: 16));
    }
    if (sanitized.length == 8) {
      return Color(int.parse(sanitized, radix: 16));
    }
    return null;
  }

  static bool _isColorDark(Color color) {
    final luminance = color.computeLuminance();
    return luminance < 0.5;
  }
}
