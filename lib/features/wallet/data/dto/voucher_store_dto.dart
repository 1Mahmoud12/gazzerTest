import 'package:gazzer/features/wallet/domain/entities/voucher_store_entity.dart';

class VoucherStoreDto {
  VoucherStoreDto({
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

  factory VoucherStoreDto.fromJson(Map<String, dynamic> json) {
    return VoucherStoreDto(
      storeId: json['store_id'] as int? ?? 0,
      storeName: json['store_name'] as String? ?? '',
      storeNameAr: json['store_name_ar'] as String? ?? '',
      isRestaurant: json['is_restaurant'] as bool? ?? false,
      voucherId: json['voucher_id'] as int? ?? 0,
      voucherCode: json['voucher_code'] as String? ?? '',
      discountType: json['discount_type'] as String? ?? '',
      discountValue: json['discount_value'] as num? ?? 0,
      amountCost: json['amount_cost'] as num? ?? 0,
      validUntil: json['valid_until'] as String? ?? '',
      image: json['store_image'] as String? ?? '',
    );
  }

  VoucherStoreEntity toEntity() => VoucherStoreEntity(
    storeId: storeId,
    storeName: storeName,
    storeNameAr: storeNameAr,
    isRestaurant: isRestaurant,
    voucherId: voucherId,
    voucherCode: voucherCode,
    discountType: discountType,
    discountValue: discountValue,
    amountCost: amountCost,
    validUntil: validUntil,
    image: image,
  );
}
