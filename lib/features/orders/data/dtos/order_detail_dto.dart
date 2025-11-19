import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/orders/domain/entities/delivery_address_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_vendor_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/domain/entities/order_summary_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';

class OrderDetailDto {
  int? id;
  int? clientId;
  int? deliveryManId;
  double? totalAmount;
  double? taxAmount;
  double? subtotal;
  double? discount;
  String? nowOrLater;
  String? shouldArriveAt;
  String? deliveryTime;
  String? orderStatus;
  List<PaymentMethodDetailDto>? paymentMethods;
  String? phoneNumber;
  String? countryPrefix;
  int? loyaltyPointsEarned;
  DeliveryAddressDetailDto? deliveryAddress;
  List<StoreDetailDto>? stores;
  OrderSummaryDto? orderSummary;
  String? createdAt;
  String? updatedAt;

  OrderDetailDto({
    this.id,
    this.clientId,
    this.deliveryManId,
    this.totalAmount,
    this.taxAmount,
    this.subtotal,
    this.discount,
    this.nowOrLater,
    this.shouldArriveAt,
    this.deliveryTime,
    this.orderStatus,
    this.paymentMethods,
    this.phoneNumber,
    this.countryPrefix,
    this.loyaltyPointsEarned,
    this.deliveryAddress,
    this.stores,
    this.orderSummary,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderDetailDto.fromJson(Map<String, dynamic> json) {
    return OrderDetailDto(
      id: json['id'] as int?,
      clientId: json['client_id'] as int?,
      deliveryManId: json['delivery_man_id'] as int?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      nowOrLater: json['now_or_later'] as String?,
      shouldArriveAt: json['should_arrive_at'] as String?,
      deliveryTime: json['delivery_time'] as String?,
      orderStatus: json['order_status'] as String?,
      paymentMethods: json['payment_methods'] != null
          ? (json['payment_methods'] as List).map((e) => PaymentMethodDetailDto.fromJson(e as Map<String, dynamic>)).toList()
          : null,
      phoneNumber: json['phone_number'] as String?,
      countryPrefix: json['country_prefix'] as String?,
      loyaltyPointsEarned: json['loyalty_points_earned'] as int?,
      deliveryAddress: json['delivery_address'] != null ? DeliveryAddressDetailDto.fromJson(json['delivery_address'] as Map<String, dynamic>) : null,
      stores: json['stores'] != null ? (json['stores'] as List).map((e) => StoreDetailDto.fromJson(e as Map<String, dynamic>)).toList() : null,
      orderSummary: json['order_summary'] != null ? OrderSummaryDto.fromJson(json['order_summary'] as Map<String, dynamic>) : null,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  OrderDetailEntity toEntity() {
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

    // Parse delivery time minutes from string like "30 دقائق" or "30 minutes"
    int? deliveryTimeMinutes;
    if (deliveryTime != null && deliveryTime!.isNotEmpty) {
      final match = RegExp(r'(\d+)').firstMatch(deliveryTime!);
      if (match != null) {
        deliveryTimeMinutes = int.tryParse(match.group(1)!);
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

    // Map stores to vendors
    final vendors =
        stores?.map((store) {
          final items =
              store.orderItems?.map((item) {
                // Extract add-ons from option_values or ordered_with
                final addOns = <String>[];
                if (item.optionValues != null) {
                  for (var optionGroup in item.optionValues!) {
                    if (optionGroup is List) {
                      for (var option in optionGroup) {
                        if (option is String && option.isNotEmpty) {
                          addOns.add(option);
                        }
                      }
                    }
                  }
                }
                if (item.orderedWith != null) {
                  for (var item in item.orderedWith!) {
                    if (item is Map && item['name'] != null) {
                      addOns.add(item['name'].toString());
                    }
                  }
                }

                // Get item name and image from orderable
                String itemName = '';
                String itemImage = '';
                if (item.orderable != null) {
                  if (item.orderable!['plate_name'] != null) {
                    itemName = item.orderable!['plate_name'] as String;
                  } else if (item.orderable!['item_name_on_this_store'] != null) {
                    itemName = item.orderable!['item_name_on_this_store'] as String;
                  }
                  itemImage = item.orderable!['image'] as String? ?? '';
                }

                return OrderDetailItemEntity(
                  id: item.id ?? 0,
                  name: itemName.isEmpty ? 'Item ${item.id ?? 0}' : itemName,
                  image: itemImage,
                  quantity: item.quantity ?? 1,
                  price: (item.price != null ? double.tryParse(item.price.toString()) : null) ?? 0.0,
                  addOns: addOns,
                );
              }).toList() ??
              [];

          return OrderDetailVendorEntity(
            vendor: OrderVendorEntity(
              id: store.storeId ?? 0,
              name: store.storeName ?? '',
              logo: store.storeImage,
              image: store.storeImage,
            ),
            items: items,
          );
        }).toList() ??
        [];

    // Get payment method
    String paymentMethod = 'Cash';
    if (paymentMethods != null && paymentMethods!.isNotEmpty) {
      final firstPayment = paymentMethods!.first;
      if (firstPayment.paymentMethod != null) {
        switch (firstPayment.paymentMethod!.toLowerCase()) {
          case 'pay_by_card':
            paymentMethod = 'Card';
            break;
          case 'pay_by_gazzer_wallet':
            paymentMethod = 'Gazzer Wallet';
            break;
          case 'e_wallet':
            paymentMethod = 'E-Wallet';
            break;
          default:
            paymentMethod = firstPayment.paymentMethod!;
        }
      }
    }

    // Get voucher info from first store
    String? voucherCode;
    String? voucherDiscountType;
    double? voucherDiscountAmount;
    if (stores != null && stores!.isNotEmpty && stores!.first.voucher != null) {
      final voucher = stores!.first.voucher!;
      voucherCode = voucher.code;
      voucherDiscountType = voucher.discountType;
      voucherDiscountAmount = (voucher.discountValue != null ? voucher.discountValue!.toDouble() : null);
    }

    // Calculate delivery fee and service fee
    // These are not directly in the API, but we can estimate or use defaults
    // The total_amount includes everything, so we calculate from subtotal
    final calculatedDeliveryFee = (totalAmount ?? 0.0) - (subtotal ?? 0.0) - (taxAmount ?? 0.0);
    final deliveryFee = calculatedDeliveryFee > 0 ? calculatedDeliveryFee : 0.0;
    final serviceFee = 0.0; // Not provided in API

    // Build delivery address
    String deliveryName = '';
    if (deliveryAddress != null) {
      // Try to use street as name, fallback to address
      if (deliveryAddress!.street != null && deliveryAddress!.street!.isNotEmpty) {
        deliveryName = deliveryAddress!.street!;
      } else if (deliveryAddress!.address != null && deliveryAddress!.address!.isNotEmpty) {
        deliveryName = deliveryAddress!.address!;
      }
    }

    final deliveryAddressEntity = deliveryAddress != null
        ? DeliveryAddressEntity(
            address: deliveryAddress!.address ?? '',
            name: deliveryName,
            mobileNumber: '${countryPrefix ?? ''}${phoneNumber ?? ''}'.trim(),
          )
        : const DeliveryAddressEntity(
            address: '',
            name: '',
            mobileNumber: '',
          );

    // Map order summary
    OrderSummaryEntity? orderSummaryEntity;
    final summary = orderSummary;
    if (summary != null) {
      // Get payment method from orderSummary if available, otherwise use parsed paymentMethod
      String summaryPaymentMethod = paymentMethod;
      if (summary.paymentMethod != null) {
        switch (summary.paymentMethod!.toLowerCase()) {
          case 'pay_by_card':
            summaryPaymentMethod = L10n.tr().creditCard;
            break;
          case 'pay_by_gazzer_wallet':
            summaryPaymentMethod = L10n.tr().gazzarWallet;
            break;
          case 'e_wallet':
            summaryPaymentMethod = L10n.tr().walletEWallet;
            break;
          case 'cash_on_delivery':
            summaryPaymentMethod = L10n.tr().cashOnDelivery;
            break;
          default:
            summaryPaymentMethod = summary.paymentMethod!;
        }
      }

      orderSummaryEntity = OrderSummaryEntity(
        subTotal: summary.subTotal ?? 0.0,
        itemDiscount: summary.itemDiscount ?? 0.0,
        vatAmount: summary.vatAmount ?? 0.0,
        serviceFees: summary.serviceFees ?? 0.0,
        coupon: summary.coupon ?? '',
        couponDiscount: summary.couponDiscount ?? 0.0,
        deliveryFees: summary.deliveryFees ?? 0.0,
        deliveryFeesDiscount: summary.deliveryFeesDiscount ?? 0.0,
        totalPaidAmount: summary.totalPaidAmount ?? 0.0,
        paymentMethod: summaryPaymentMethod,
        pointsEarned: summary.pointsEarned ?? 0,
      );
    }

    return OrderDetailEntity(
      orderId: id ?? 0,
      orderDate: orderDate,
      status: status,
      deliveryTimeMinutes: deliveryTimeMinutes,
      deliveryAddress: deliveryAddressEntity,
      vendors: vendors,
      subTotal: subtotal ?? 0.0,
      discount: discount ?? 0.0,
      deliveryFee: deliveryFee,
      serviceFee: serviceFee,
      total: totalAmount ?? 0.0,
      paymentMethod: paymentMethod,
      voucherCode: voucherCode,
      voucherDiscountType: voucherDiscountType,
      voucherDiscountAmount: voucherDiscountAmount,
      loyaltyPointsEarned: loyaltyPointsEarned ?? 0,
      orderSummary: orderSummaryEntity,
    );
  }
}

class PaymentMethodDetailDto {
  String? paymentMethod;
  double? amount;
  String? paymentStatus;
  String? paidAt;

  PaymentMethodDetailDto({
    this.paymentMethod,
    this.amount,
    this.paymentStatus,
    this.paidAt,
  });

  factory PaymentMethodDetailDto.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDetailDto(
      paymentMethod: json['payment_method'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      paymentStatus: json['payment_status'] as String?,
      paidAt: json['paid_at'] as String?,
    );
  }
}

class DeliveryAddressDetailDto {
  String? address;
  String? building;
  String? floor;
  String? apartment;
  String? street;
  String? long;
  String? lat;
  String? province;
  String? provinceZone;

  DeliveryAddressDetailDto({
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

  factory DeliveryAddressDetailDto.fromJson(Map<String, dynamic> json) {
    // Build full address from components
    final addressParts = <String>[];
    if (json['street'] != null && json['street'].toString().isNotEmpty) {
      addressParts.add(json['street'].toString());
    }
    if (json['address'] != null && json['address'].toString().isNotEmpty) {
      addressParts.add(json['address'].toString());
    }
    if (json['building'] != null && json['building'].toString().isNotEmpty) {
      addressParts.add('Building: ${json['building']}');
    }
    if (json['floor'] != null && json['floor'].toString().isNotEmpty) {
      addressParts.add('Floor: ${json['floor']}');
    }
    if (json['apartment'] != null && json['apartment'].toString().isNotEmpty) {
      addressParts.add('Apartment: ${json['apartment']}');
    }

    final fullAddress = addressParts.isNotEmpty ? addressParts.join(', ') : json['address'] as String? ?? '';

    return DeliveryAddressDetailDto(
      address: fullAddress,
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

class StoreDetailDto {
  int? storeId;
  String? storeName;
  String? storeNameAr;
  String? storeImage;
  bool? isRestaurant;
  double? subtotalBeforeVoucher;
  VoucherDetailDto? voucher;
  double? discountAmount;
  double? totalAfterVoucher;
  List<OrderItemDetailDto>? orderItems;

  StoreDetailDto({
    this.storeId,
    this.storeName,
    this.storeNameAr,
    this.storeImage,
    this.isRestaurant,
    this.subtotalBeforeVoucher,
    this.voucher,
    this.discountAmount,
    this.totalAfterVoucher,
    this.orderItems,
  });

  factory StoreDetailDto.fromJson(Map<String, dynamic> json) {
    return StoreDetailDto(
      storeId: json['store_id'] as int?,
      storeName: json['store_name'] as String?,
      storeNameAr: json['store_name_ar'] as String?,
      storeImage: json['store_image'] as String?,
      isRestaurant: json['is_restaurant'] as bool?,
      subtotalBeforeVoucher: (json['subtotal_before_voucher'] as num?)?.toDouble(),
      voucher: json['voucher'] != null ? VoucherDetailDto.fromJson(json['voucher'] as Map<String, dynamic>) : null,
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      totalAfterVoucher: (json['total_after_voucher'] as num?)?.toDouble(),
      orderItems: json['order_items'] != null
          ? (json['order_items'] as List).map((e) => OrderItemDetailDto.fromJson(e as Map<String, dynamic>)).toList()
          : null,
    );
  }
}

class VoucherDetailDto {
  String? code;
  String? discountType;
  int? discountValue;

  VoucherDetailDto({
    this.code,
    this.discountType,
    this.discountValue,
  });

  factory VoucherDetailDto.fromJson(Map<String, dynamic> json) {
    return VoucherDetailDto(
      code: json['code'] as String?,
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as int?,
    );
  }
}

class OrderItemDetailDto {
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

  OrderItemDetailDto({
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

  factory OrderItemDetailDto.fromJson(Map<String, dynamic> json) {
    return OrderItemDetailDto(
      id: json['id'] as int?,
      orderableType: json['orderable_type'] as String?,
      orderableId: json['orderable_id'] as int?,
      unitPrice: json['unit_price']?.toString(),
      optionValues: json['option_values'] as List<dynamic>?,
      orderedWith: json['ordered_with'] as List<dynamic>?,
      notes: json['notes'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price']?.toString(),
      orderable: json['orderable'] as Map<String, dynamic>?,
    );
  }
}

class OrderSummaryDto {
  double? subTotal;
  double? itemDiscount;
  double? vatAmount;
  double? serviceFees;
  String? coupon;
  double? couponDiscount;
  double? deliveryFees;
  double? deliveryFeesDiscount;
  double? totalPaidAmount;
  String? paymentMethod;
  int? pointsEarned;

  OrderSummaryDto({
    this.subTotal,
    this.itemDiscount,
    this.vatAmount,
    this.serviceFees,
    this.coupon,
    this.couponDiscount,
    this.deliveryFees,
    this.deliveryFeesDiscount,
    this.totalPaidAmount,
    this.paymentMethod,
    this.pointsEarned,
  });

  factory OrderSummaryDto.fromJson(Map<String, dynamic> json) {
    return OrderSummaryDto(
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      itemDiscount: (json['item_discount'] as num?)?.toDouble(),
      vatAmount: (json['vat_amount'] as num?)?.toDouble(),
      serviceFees: (json['service_fees'] as num?)?.toDouble(),
      coupon: json['coupon'],
      couponDiscount: (json['coupon_discount'] as num?)?.toDouble(),
      deliveryFees: (json['delivery_fees'] as num?)?.toDouble(),
      deliveryFeesDiscount: (json['delivery_fees_discount'] as num?)?.toDouble(),
      totalPaidAmount: (json['total_paid_amount'] as num?)?.toDouble(),
      paymentMethod: json['payment_method'] as String?,
      pointsEarned: json['points_earned'] as int?,
    );
  }
}

class CouponDto {
  String? code;
  String? discountType;
  double? discountValue;

  CouponDto({
    this.code,
    this.discountType,
    this.discountValue,
  });

  factory CouponDto.fromJson(Map<String, dynamic> json) {
    return CouponDto(
      code: json['code'] as String?,
      discountType: json['discount_type'] as String?,
      discountValue: (json['discount_value'] as num?)?.toDouble(),
    );
  }
}
