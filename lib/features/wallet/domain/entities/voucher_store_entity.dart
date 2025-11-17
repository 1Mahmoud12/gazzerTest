class VoucherStoreEntity {
  const VoucherStoreEntity({
    required this.storeId,
    required this.storeName,
    required this.storeNameAr,
    required this.isRestaurant,
    required this.voucherId,
    required this.voucherCode,
    required this.discountType,
    required this.discountValue,
    required this.amountCost,
    required this.validUntil,
    required this.image,
  });

  final int storeId;
  final String storeName;
  final String storeNameAr;
  final bool isRestaurant;
  final int voucherId;
  final String voucherCode;
  final String discountType;
  final num discountValue;
  final num amountCost;
  final String validUntil;
  final String image;
}
