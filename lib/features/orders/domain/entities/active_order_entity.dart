import 'order_status.dart';

class ActiveOrderEntity {
  final String orderId;
  final List<String> vendorNames;
  final double price;
  final int itemsCount;
  final DateTime arriveDate;
  final OrderStatus status;
  final int remainingMinutes;
  final bool showMap;

  const ActiveOrderEntity({
    required this.orderId,
    required this.vendorNames,
    required this.price,
    required this.itemsCount,
    required this.arriveDate,
    required this.status,
    required this.remainingMinutes,
    required this.showMap,
  });

  String get primaryVendorName => vendorNames.isNotEmpty ? vendorNames.first : '';

  bool get hasMultipleVendors => vendorNames.length > 1;
}
