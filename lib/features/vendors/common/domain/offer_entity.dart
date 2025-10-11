import 'package:gazzer/core/presentation/extensions/enum.dart';

class OfferEntity {
  final int id;
  final String? expiredAt;
  final double discount;
  final DiscountType discountType;

  OfferEntity({
    required this.id,
    this.expiredAt,
    required this.discount,
    required this.discountType,
  });
  double priceAfterDiscount(double price) {
    return switch (discountType) {
      DiscountType.percentage => price - (price * discount / 100),
      DiscountType.fixed => price - discount,
      _ => price, // No discount
    };
  }

  bool isExpired() {
    return expiredAt != null && DateTime.now().isAfter(DateTime.parse(expiredAt!));
  }
}
