enum LoyaltyTierName {
  saver('SAVER'),
  gainer('GAINER'),
  winner('WINNER'),
  hero('HERO');

  const LoyaltyTierName(this.value);

  final String value;

  static LoyaltyTierName fromString(String value) {
    return LoyaltyTierName.values.firstWhere((tier) => tier.value.toUpperCase() == value.toUpperCase(), orElse: () => LoyaltyTierName.saver);
  }
}
