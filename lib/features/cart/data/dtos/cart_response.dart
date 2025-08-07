import 'package:gazzer/features/cart/data/dtos/cart_vendor_dto.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';

class CartResponse {
  late final int? addressId;
  late final double subTotal;
  late final double deliveryFee;
  late final double serviceFee;
  late final double discount;
  late final double total;
  late final List<CartVendorEntity> vendors;

  CartResponse({
    this.addressId,
    required this.subTotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.discount,
    required this.total,
    required this.vendors,
  });

  CartResponse.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    subTotal = json['subtotal']?.toDouble() ?? 0.0;
    deliveryFee = json['delivery_fee']?.toDouble() ?? 0.0;
    serviceFee = json['service_fee']?.toDouble() ?? 0.0;
    discount = json['discount']?.toDouble() ?? 0.0;
    total = json['total']?.toDouble() ?? 0.0;

    if (json['items'] != null) {
      vendors = <CartVendorEntity>[];
      json['items'].forEach((v) {
        vendors.add(CartVendorDTO.fromJson(v).toEntity());
      });
    } else {
      vendors = [];
    }
  }
}
