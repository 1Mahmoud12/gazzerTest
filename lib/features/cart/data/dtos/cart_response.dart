import 'package:gazzer/features/cart/data/dtos/cart_vendor_dto.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/models/cart_summary_model.dart';

class CartResponse {
  late final String? message;
  late final int? addressId;
  late final CartSummaryModel summary;
  late final List<CartVendorEntity> vendors;

  CartResponse({
    this.message,
    this.addressId,
    required this.summary,
    required this.vendors,
  });

  CartResponse.fromJson(Map<String, dynamic> json, {String? msg}) {
    message = msg;
    addressId = json['client_address_id'] is int? ? json['client_address_id'] : json['client_address_id']['id'];
    summary = CartSummaryModel(
      subTotal: json['subtotal']?.toDouble() ?? 0.0,
      deliveryFee: json['delivery_fee']?.toDouble() ?? 0.0,
      serviceFee: json['service_fee']?.toDouble() ?? 0.0,
      discount: json['discount']?.toDouble() ?? 0.0,
      total: json['total']?.toDouble() ?? 0.0,
    );

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
