import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/loyaltyProgram/domain/enums/loyalty_tier_name.dart';

extension LoyaltyTierNameExtension on LoyaltyTierName {
  /// Gets the translated display name for the tier
  String getDisplayName([context]) {
    final l10n = L10n.tr(context);
    switch (this) {
      case LoyaltyTierName.saver:
        return l10n.tierSaver;
      case LoyaltyTierName.gainer:
        return l10n.tierGainer;
      case LoyaltyTierName.winner:
        return l10n.tierWinner;
      case LoyaltyTierName.hero:
        return l10n.tierHero;
    }
  }
}
