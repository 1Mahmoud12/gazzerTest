import 'delivery_address_entity.dart';
import 'order_detail_vendor_entity.dart';
import 'order_status.dart';

class OrderDetailEntity {
  final int orderId;
  final DateTime orderDate;
  final OrderStatus status;
  final int? deliveryTimeMinutes; // e.g., 40
  final DeliveryAddressEntity deliveryAddress;
  final List<OrderDetailVendorEntity> vendors;
  final double subTotal;
  final double discount;
  final double deliveryFee;
  final double serviceFee;
  final double total;
  final String paymentMethod;
  final String? voucherCode;
  final String? voucherDiscountType; // 'fixed' or 'percentage'
  final double? voucherDiscountAmount;

  const OrderDetailEntity({
    required this.orderId,
    required this.orderDate,
    required this.status,
    this.deliveryTimeMinutes,
    required this.deliveryAddress,
    required this.vendors,
    required this.subTotal,
    this.discount = 0.0,
    this.deliveryFee = 0.0,
    this.serviceFee = 0.0,
    required this.total,
    required this.paymentMethod,
    this.voucherCode,
    this.voucherDiscountType,
    this.voucherDiscountAmount,
  });
}
