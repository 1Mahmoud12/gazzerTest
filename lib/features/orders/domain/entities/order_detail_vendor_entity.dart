import 'order_detail_item_entity.dart';
import 'order_vendor_entity.dart';

class OrderDetailVendorEntity {
  final OrderVendorEntity vendor;
  final List<OrderDetailItemEntity> items;

  const OrderDetailVendorEntity({
    required this.vendor,
    required this.items,
  });

  int get itemsCount => items.length;
}
