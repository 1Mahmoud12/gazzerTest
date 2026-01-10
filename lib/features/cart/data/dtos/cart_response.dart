import 'package:gazzer/features/cart/data/dtos/cart_vendor_dto.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/models/cart_summary_model.dart';

class CartResponse {
  late final String? message;
  late final int? addressId;
  late final CartSummaryModel summary;
  late final List<CartVendorEntity> vendors;
  late final List<ItemPouch> pouches;
  late final PouchSummary pouchSummary;

  CartResponse({
    this.message,
    this.addressId,
    required this.summary,
    required this.vendors,
    required this.pouchSummary,
    required this.pouches,
  });

  CartResponse.fromJson(Map<String, dynamic> json, {String? msg}) {
    message = msg;
    addressId = json['client_address_id'] is int?
        ? json['client_address_id']
        : json['client_address_id']['id'];
    summary = CartSummaryModel(
      subTotal: json['subtotal']?.toDouble() ?? 0.0,
      deliveryFee: json['delivery_fee']?.toDouble() ?? 0.0,
      serviceFee: json['service_fee']?.toDouble() ?? 0.0,
      discount: json['discount']?.toDouble() ?? 0.0,
      total: json['total']?.toDouble() ?? 0.0,
      tax: json['tax']?.toDouble() ?? 0.0,
      deliveryFeeDiscount: json['delivery_fee_discount']?.toDouble() ?? 0.0,
    );
    pouchSummary = PouchSummary.fromJson(json['vehicle_box_types_summary']);
    if (json['items'] != null) {
      vendors = <CartVendorEntity>[];
      json['items'].forEach((v) {
        vendors.add(CartVendorDTO.fromJson(v).toEntity());
      });
    } else {
      vendors = [];
    }
    if (json['vehicle_box_types'] != null) {
      pouches = <ItemPouch>[];
      json['vehicle_box_types'].forEach((v) {
        pouches.add(ItemPouch.fromJson(v));
      });
    } else {
      pouches = [];
    }
  }
}

class ItemPouch {
  ItemPouch({
    required this.pouchId,
    required this.maxCapacity,
    required this.currentLoad,
    required this.fillPercentage,
    required this.loadPercentageExact,
    required this.remainingCapacity,
    required this.isOverCapacity,
    required this.items,
  });

  final int? pouchId;
  final num? maxCapacity;
  final num? currentLoad;
  final num? fillPercentage;
  final num? loadPercentageExact;
  final num? remainingCapacity;
  final bool? isOverCapacity;
  final List<Item> items;

  factory ItemPouch.fromJson(Map<String, dynamic> json) {
    return ItemPouch(
      pouchId: json['vehicle_box_type_id'],
      maxCapacity: json['max_capacity'],
      currentLoad: json['current_load'],
      fillPercentage: json['fill_percentage'],
      loadPercentageExact: json['load_percentage_exact'],
      remainingCapacity: json['remaining_capacity'],
      isOverCapacity: json['is_over_capacity'],
      items: json['items'] == null
          ? []
          : List<Item>.from(json['items']!.map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'pouch_id': pouchId,
    'max_capacity': maxCapacity,
    'current_load': currentLoad,
    'fill_percentage': fillPercentage,
    'load_percentage_exact': loadPercentageExact,
    'remaining_capacity': remainingCapacity,
    'is_over_capacity': isOverCapacity,
    'items': items.map((x) => x.toJson()).toList(),
  };
}

class Item {
  Item({
    required this.itemId,
    required this.name,
    required this.weight,
    required this.quantity,
  });

  final int? itemId;
  final String? name;
  final num? weight;
  final num? quantity;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['item_id'],
      name: json['name'],
      weight: json['weight'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'name': name,
    'weight': weight,
    'quantity': quantity,
  };
}

class PouchSummary {
  PouchSummary({
    required this.totalPouches,
    required this.totalCapacity,
    required this.totalLoad,
    required this.totalFillPercentage,
    required this.totalLoadPercentageExact,
  });

  final num? totalPouches;
  final num? totalCapacity;
  final num? totalLoad;
  final num? totalFillPercentage;
  final num? totalLoadPercentageExact;

  factory PouchSummary.fromJson(Map<String, dynamic> json) {
    return PouchSummary(
      totalPouches: json['total_vehicle_box_types'],
      totalCapacity: json['total_capacity'],
      totalLoad: json['total_load'],
      totalFillPercentage: json['total_fill_percentage'],
      totalLoadPercentageExact: json['total_load_percentage_exact'],
    );
  }

  Map<String, dynamic> toJson() => {
    'total_pouches': totalPouches,
    'total_capacity': totalCapacity,
    'total_load': totalLoad,
    'total_fill_percentage': totalFillPercentage,
    'total_load_percentage_exact': totalLoadPercentageExact,
  };
}
