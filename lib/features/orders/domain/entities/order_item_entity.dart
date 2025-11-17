import 'order_status.dart';
import 'order_vendor_entity.dart';

class OrderItemEntity {
  final String orderId;
  final List<OrderVendorEntity> vendors;
  final double price;
  final int itemsCount;
  final DateTime orderDate;
  final OrderStatus status;
  final double? rating; // null if not rated
  final bool canRate; // true if delivered and not yet rated

  const OrderItemEntity({
    required this.orderId,
    required this.vendors,
    required this.price,
    required this.itemsCount,
    required this.orderDate,
    required this.status,
    this.rating,
    this.canRate = false,
  });

  bool get hasMultipleVendors => vendors.length > 1;

  OrderVendorEntity get primaryVendor => vendors.first;
}
