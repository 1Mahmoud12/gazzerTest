import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';

class OrderDto {
  int? id;
  int? clientId;
  int? deliveryManId;
  double? totalAmount;
  double? taxAmount;
  String? nowOrLater;
  String? shouldArriveAt;
  String? orderStatus;
  List<PaymentMethodDto>? paymentMethods;
  DeliveryAddressDto? deliveryAddress;
  List<StoreDto>? stores;
  String? createdAt;
  String? updatedAt;
  num? averageRate;
  bool? isHasReview;

  OrderDto({
    this.id,
    this.clientId,
    this.deliveryManId,
    this.totalAmount,
    this.taxAmount,
    this.nowOrLater,
    this.shouldArriveAt,
    this.orderStatus,
    this.paymentMethods,
    this.deliveryAddress,
    this.stores,
    this.createdAt,
    this.updatedAt,
    this.averageRate,
    this.isHasReview,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
      id: json['id'] as int?,
      clientId: json['client_id'] as int?,
      deliveryManId: json['delivery_man_id'] as int?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      nowOrLater: json['now_or_later'] as String?,
      shouldArriveAt: json['should_arrive_at'] as String?,
      orderStatus: json['order_status'] as String?,
      averageRate: json['average_rate'] as num?,
      isHasReview: json['is_has_review'] as bool?,

      paymentMethods: json['payment_methods'] != null
          ? (json['payment_methods'] as List).map((e) => PaymentMethodDto.fromJson(e as Map<String, dynamic>)).toList()
          : null,
      deliveryAddress: json['delivery_address'] != null ? DeliveryAddressDto.fromJson(json['delivery_address'] as Map<String, dynamic>) : null,
      stores: json['stores'] != null ? (json['stores'] as List).map((e) => StoreDto.fromJson(e as Map<String, dynamic>)).toList() : null,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  OrderItemEntity toEntity() {
    // Map stores to vendors
    final vendors =
        stores?.map((store) {
          return OrderVendorEntity(
            id: store.storeId ?? 0,
            name: store.storeName ?? '',
            logo: store.storeImage,
            image: store.storeImage,
          );
        }).toList() ??
        [];

    // Calculate total items count
    final itemsCount =
        stores?.fold<int>(
          0,
          (sum, store) => sum + (store.orderItems?.length ?? 0),
        ) ??
        0;

    // Parse order status
    OrderStatus status = OrderStatus.pending;
    if (orderStatus != null) {
      switch (orderStatus!.toLowerCase()) {
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
    }

    // Parse date
    DateTime orderDate = DateTime.now();
    if (createdAt != null) {
      try {
        orderDate = DateTime.parse(createdAt!);
      } catch (e) {
        orderDate = DateTime.now();
      }
    }

    return OrderItemEntity(
      orderId: id?.toString() ?? '',
      vendors: vendors,
      price: totalAmount ?? 0.0,
      itemsCount: itemsCount,
      orderDate: orderDate,
      status: status,
      canRate: isHasReview ?? false,
      rating: averageRate ?? 0.0,
    );
  }
}

class PaymentMethodDto {
  String? paymentMethod;
  double? amount;
  String? paymentStatus;
  String? paidAt;

  PaymentMethodDto({
    this.paymentMethod,
    this.amount,
    this.paymentStatus,
    this.paidAt,
  });

  factory PaymentMethodDto.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDto(
      paymentMethod: json['payment_method'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      paymentStatus: json['payment_status'] as String?,
      paidAt: json['paid_at'] as String?,
    );
  }
}

class DeliveryAddressDto {
  String? address;
  String? building;
  String? floor;
  String? apartment;
  String? street;
  String? long;
  String? lat;
  String? province;
  String? provinceZone;

  DeliveryAddressDto({
    this.address,
    this.building,
    this.floor,
    this.apartment,
    this.street,
    this.long,
    this.lat,
    this.province,
    this.provinceZone,
  });

  factory DeliveryAddressDto.fromJson(Map<String, dynamic> json) {
    return DeliveryAddressDto(
      address: json['address'] as String?,
      building: json['building'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      street: json['street'] as String?,
      long: json['long'] as String?,
      lat: json['lat'] as String?,
      province: json['province'] as String?,
      provinceZone: json['province_zone'] as String?,
    );
  }
}

class StoreDto {
  int? storeId;
  String? storeName;
  String? storeNameAr;
  bool? isRestaurant;
  double? subtotalBeforeVoucher;
  VoucherDto? voucher;
  double? discountAmount;
  double? totalAfterVoucher;
  List<OrderItemDto>? orderItems;
  String? storeImage;

  StoreDto({
    this.storeId,
    this.storeName,
    this.storeNameAr,
    this.isRestaurant,
    this.subtotalBeforeVoucher,
    this.voucher,
    this.discountAmount,
    this.totalAfterVoucher,
    this.orderItems,
    this.storeImage,
  });

  factory StoreDto.fromJson(Map<String, dynamic> json) {
    return StoreDto(
      storeId: json['store_id'] as int?,
      storeName: json['store_name'] as String?,
      storeNameAr: json['store_name_ar'] as String?,
      isRestaurant: json['is_restaurant'] as bool?,
      subtotalBeforeVoucher: (json['subtotal_before_voucher'] as num?)?.toDouble(),
      voucher: json['voucher'] != null ? VoucherDto.fromJson(json['voucher'] as Map<String, dynamic>) : null,
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      totalAfterVoucher: (json['total_after_voucher'] as num?)?.toDouble(),
      orderItems: json['order_items'] != null
          ? (json['order_items'] as List).map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>)).toList()
          : null,
      storeImage:
          json['order_items'] != null &&
              (json['order_items'] as List).isNotEmpty &&
              (json['order_items'] as List)[0]['orderable'] != null &&
              (json['order_items'] as List)[0]['orderable']['store'] != null
          ? (json['order_items'] as List)[0]['orderable']['store']['image'] as String?
          : null,
    );
  }
}

class VoucherDto {
  String? code;
  String? discountType;
  int? discountValue;

  VoucherDto({
    this.code,
    this.discountType,
    this.discountValue,
  });

  factory VoucherDto.fromJson(Map<String, dynamic> json) {
    return VoucherDto(
      code: json['code'] as String?,
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as int?,
    );
  }
}

class OrderItemDto {
  int? id;
  String? orderableType;
  int? orderableId;
  String? unitPrice;
  List<dynamic>? optionValues;
  List<dynamic>? orderedWith;
  String? notes;
  int? quantity;
  String? price;
  Map<String, dynamic>? orderable;

  OrderItemDto({
    this.id,
    this.orderableType,
    this.orderableId,
    this.unitPrice,
    this.optionValues,
    this.orderedWith,
    this.notes,
    this.quantity,
    this.price,
    this.orderable,
  });

  factory OrderItemDto.fromJson(Map<String, dynamic> json) {
    return OrderItemDto(
      id: json['id'] as int?,
      orderableType: json['orderable_type'] as String?,
      orderableId: json['orderable_id'] as int?,
      unitPrice: (json['unit_price'] as String?)?.toString(),
      optionValues: json['option_values'] as List<dynamic>?,
      orderedWith: json['ordered_with'] as List<dynamic>?,
      notes: json['notes'] as String?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as String?)?.toString(),
      orderable: json['orderable'] as Map<String, dynamic>?,
    );
  }
}
