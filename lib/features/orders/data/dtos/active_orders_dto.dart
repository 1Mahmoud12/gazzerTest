import 'package:gazzer/features/orders/domain/entities/active_order_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';

class ActiveOrdersResponseDto {
  final bool status;
  final List<ActiveOrderDto> data;

  ActiveOrdersResponseDto({required this.status, required this.data});

  factory ActiveOrdersResponseDto.fromJson(Map<String, dynamic> json) {
    return ActiveOrdersResponseDto(
      status: json['status'] as bool? ?? false,
      data: (json['data'] as List<dynamic>?)?.map((e) => ActiveOrderDto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  List<ActiveOrderEntity> toEntities() {
    return data.map((dto) => dto.toEntity()).toList();
  }
}

class ActiveOrderDto {
  final int id;
  final List<String> vendorNames;
  final String orderStatus;
  final String totalAmount;
  final int itemsCount;
  final String shouldArriveAt;
  final int remainingMinutes;
  final bool showMap;

  ActiveOrderDto({
    required this.id,
    required this.vendorNames,
    required this.orderStatus,
    required this.totalAmount,
    required this.itemsCount,
    required this.shouldArriveAt,
    required this.remainingMinutes,
    required this.showMap,
  });

  factory ActiveOrderDto.fromJson(Map<String, dynamic> json) {
    return ActiveOrderDto(
      id: json['id'] as int? ?? 0,
      vendorNames: (json['vendor_names'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      orderStatus: json['order_status'] as String? ?? 'pending',
      totalAmount: json['total_amount'] as String? ?? '0',
      itemsCount: json['items_count'] as int? ?? 0,
      shouldArriveAt: json['should_arrive_at'] as String? ?? '',
      remainingMinutes: json['remaining_minutes'] as int? ?? 0,
      showMap: json['show_map'] as bool? ?? false,
    );
  }

  ActiveOrderEntity toEntity() {
    // Parse order status
    OrderStatus status = OrderStatus.pending;
    switch (orderStatus.toLowerCase()) {
      case 'delivered':
        status = OrderStatus.delivered;
        break;
      case 'cancelled':
        status = OrderStatus.cancelled;
        break;
      case 'preparing':
        status = OrderStatus.preparing;
        break;
      case 'pending':
        status = OrderStatus.pending;
        break;
    }

    // Parse date
    DateTime arriveDate = DateTime.now();
    if (shouldArriveAt.isNotEmpty) {
      try {
        arriveDate = DateTime.parse(shouldArriveAt);
      } catch (e) {
        arriveDate = DateTime.now();
      }
    }

    // Parse total amount
    final price = double.tryParse(totalAmount) ?? 0.0;

    return ActiveOrderEntity(
      orderId: id.toString(),
      vendorNames: vendorNames,
      price: price,
      itemsCount: itemsCount,
      arriveDate: arriveDate,
      status: status,
      remainingMinutes: remainingMinutes,
      showMap: showMap,
    );
  }
}
