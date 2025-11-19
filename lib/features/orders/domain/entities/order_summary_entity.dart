class OrderSummaryEntity {
  final double subTotal;
  final double itemDiscount;
  final double vatAmount;
  final double serviceFees;
  final String? coupon;
  final double couponDiscount;
  final double deliveryFees;
  final double deliveryFeesDiscount;
  final double totalPaidAmount;
  final String paymentMethod;
  final int pointsEarned;

  const OrderSummaryEntity({
    required this.subTotal,
    required this.itemDiscount,
    required this.vatAmount,
    required this.serviceFees,
    this.coupon,
    required this.couponDiscount,
    required this.deliveryFees,
    required this.deliveryFeesDiscount,
    required this.totalPaidAmount,
    required this.paymentMethod,
    required this.pointsEarned,
  });
}

class CouponEntity {
  final String code;
  final String discountType;
  final double discountValue;

  const CouponEntity({
    required this.code,
    required this.discountType,
    required this.discountValue,
  });
}
