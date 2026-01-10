import 'package:gazzer/core/presentation/extensions/enum.dart';

class OfferEntity {
  final int id;
  final String? expiredAt;
  final double discount;
  final DiscountType discountType;
  final num maxDiscount;

  OfferEntity({required this.id, this.expiredAt, required this.discount, required this.discountType, required this.maxDiscount});
  double priceAfterDiscount(double price) {
    return switch (discountType) {
      DiscountType.percentage => price - ((price * discount / 100) > maxDiscount ? maxDiscount : (price * discount / 100)),
      DiscountType.fixed => price - (discount > maxDiscount ? maxDiscount : discount),
      _ => price, // No discount
    };
  }

  bool isExpired() {
    return expiredAt != null && DateTime.now().isAfter(DateTime.parse(expiredAt!));
  }
}
