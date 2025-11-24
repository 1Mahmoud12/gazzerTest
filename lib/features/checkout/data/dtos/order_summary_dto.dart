class OrderSummaryDTO {
  final List<OrderSummaryStoreDTO> items;
  final int clientAddressId;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double serviceFee;
  final double discount;
  final double total;
  final List<VehicleBoxTypeDTO> vehicleBoxTypes;
  final VehicleBoxTypesSummaryDTO vehicleBoxTypesSummary;
  final bool needsNewPouchApproval;
  final OrderSummaryVoucherDTO? voucher;
  final String? voucherDiscount;

  OrderSummaryDTO({
    required this.items,
    required this.clientAddressId,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.serviceFee,
    required this.discount,
    required this.total,
    required this.vehicleBoxTypes,
    required this.vehicleBoxTypesSummary,
    required this.needsNewPouchApproval,
    this.voucher,
    this.voucherDiscount,
  });

  factory OrderSummaryDTO.fromJson(Map<String, dynamic> json) {
    return OrderSummaryDTO(
      items: (json['items'] as List<dynamic>).map((e) => OrderSummaryStoreDTO.fromJson(e as Map<String, dynamic>)).toList(),
      clientAddressId: json['client_address_id'] as int,
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      serviceFee: (json['service_fee'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      vehicleBoxTypes:
          (json['vehicle_box_types'] as List<dynamic>?)
              ?.map(
                (e) => VehicleBoxTypeDTO.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      vehicleBoxTypesSummary: VehicleBoxTypesSummaryDTO.fromJson(
        json['vehicle_box_types_summary'] as Map<String, dynamic>,
      ),
      needsNewPouchApproval: json['needs_new_pouch_approval'] as bool? ?? false,
      voucher: json['voucher'] != null
          ? OrderSummaryVoucherDTO.fromJson(
              json['voucher'] as Map<String, dynamic>,
            )
          : null,
      voucherDiscount: json['voucher_discount'].toString() as String?,
    );
  }
}

class OrderSummaryStoreDTO {
  final int storeId;
  final String storeName;
  final String storeImage;
  final String type;
  final List<OrderSummaryItemDTO> items;

  OrderSummaryStoreDTO({
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.type,
    required this.items,
  });

  factory OrderSummaryStoreDTO.fromJson(Map<String, dynamic> json) {
    return OrderSummaryStoreDTO(
      storeId: json['store_id'] as int,
      storeName: json['store_name'] as String,
      storeImage: json['store_image'] as String,
      type: json['type'] as String,
      items: (json['items'] as List<dynamic>).map((e) => OrderSummaryItemDTO.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class OrderSummaryItemDTO {
  final int id;
  final String cartableType;
  final Map<String, dynamic> cartable;
  final int quantity;
  final double weight;
  final List<OrderSummaryOptionValueDTO> optionValues;
  final List<dynamic> orderedWith;
  final double itemPrice;
  final String? notes;

  OrderSummaryItemDTO({
    required this.id,
    required this.cartableType,
    required this.cartable,
    required this.quantity,
    required this.weight,
    required this.optionValues,
    required this.orderedWith,
    required this.itemPrice,
    this.notes,
  });

  factory OrderSummaryItemDTO.fromJson(Map<String, dynamic> json) {
    return OrderSummaryItemDTO(
      id: json['id'] as int,
      cartableType: json['cartable_type'] as String,
      cartable: json['cartable'] as Map<String, dynamic>,
      quantity: json['quantity'] as int,
      weight: (json['weight'] as num).toDouble(),
      optionValues:
          (json['option_values'] as List<dynamic>?)
              ?.map(
                (e) => OrderSummaryOptionValueDTO.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      orderedWith: json['ordered_with'] as List<dynamic>? ?? [],
      itemPrice: (json['item_price'] as num).toDouble(),
      notes: json['notes'] as String?,
    );
  }
}

class OrderSummaryOptionValueDTO {
  final int optionId;
  final String optionName;
  final List<OrderSummaryValueDTO> values;

  OrderSummaryOptionValueDTO({
    required this.optionId,
    required this.optionName,
    required this.values,
  });

  factory OrderSummaryOptionValueDTO.fromJson(Map<String, dynamic> json) {
    return OrderSummaryOptionValueDTO(
      optionId: json['option_id'] as int,
      optionName: json['option_name'] as String,
      values: (json['values'] as List<dynamic>).map((e) => OrderSummaryValueDTO.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class OrderSummaryValueDTO {
  final String valueId;
  final String valueName;

  OrderSummaryValueDTO({
    required this.valueId,
    required this.valueName,
  });

  factory OrderSummaryValueDTO.fromJson(Map<String, dynamic> json) {
    return OrderSummaryValueDTO(
      valueId: json['value_id'] as String,
      valueName: json['value_name'] as String,
    );
  }
}

class VehicleBoxTypeDTO {
  final int boxNumber;
  final int vehicleBoxTypeId;
  final double maxCapacity;
  final double currentLoad;
  final int fillPercentage;
  final double loadPercentageExact;
  final double remainingCapacity;
  final bool isOverCapacity;
  final Map<String, dynamic> maxDimensions;
  final bool hasPartitions;
  final Map<String, dynamic> volume;
  final List<VehicleBoxItemDTO> items;

  VehicleBoxTypeDTO({
    required this.boxNumber,
    required this.vehicleBoxTypeId,
    required this.maxCapacity,
    required this.currentLoad,
    required this.fillPercentage,
    required this.loadPercentageExact,
    required this.remainingCapacity,
    required this.isOverCapacity,
    required this.maxDimensions,
    required this.hasPartitions,
    required this.volume,
    required this.items,
  });

  factory VehicleBoxTypeDTO.fromJson(Map<String, dynamic> json) {
    return VehicleBoxTypeDTO(
      boxNumber: json['box_number'] as int,
      vehicleBoxTypeId: json['vehicle_box_type_id'] as int,
      maxCapacity: (json['max_capacity'] as num).toDouble(),
      currentLoad: (json['current_load'] as num).toDouble(),
      fillPercentage: json['fill_percentage'] as int,
      loadPercentageExact: (json['load_percentage_exact'] as num).toDouble(),
      remainingCapacity: (json['remaining_capacity'] as num).toDouble(),
      isOverCapacity: json['is_over_capacity'] as bool,
      maxDimensions: json['max_dimensions'] as Map<String, dynamic>,
      hasPartitions: json['has_partitions'] as bool,
      volume: json['volume'] as Map<String, dynamic>,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => VehicleBoxItemDTO.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class VehicleBoxItemDTO {
  final int itemId;
  final String name;
  final double weight;
  final int quantity;
  final Map<String, dynamic> dimensions;
  final double volume;
  final Map<String, dynamic> weightDetails;

  VehicleBoxItemDTO({
    required this.itemId,
    required this.name,
    required this.weight,
    required this.quantity,
    required this.dimensions,
    required this.volume,
    required this.weightDetails,
  });

  factory VehicleBoxItemDTO.fromJson(Map<String, dynamic> json) {
    return VehicleBoxItemDTO(
      itemId: json['item_id'] as int,
      name: json['name'] as String,
      weight: (json['weight'] as num).toDouble(),
      quantity: json['quantity'] as int,
      dimensions: json['dimensions'] as Map<String, dynamic>,
      volume: (json['volume'] as num).toDouble(),
      weightDetails: json['weight_details'] as Map<String, dynamic>,
    );
  }
}

class VehicleBoxTypesSummaryDTO {
  final int totalVehicleBoxTypes;
  final double totalCapacity;
  final double totalLoad;
  final int totalFillPercentage;
  final double totalLoadPercentageExact;
  final Map<String, dynamic> volume;

  VehicleBoxTypesSummaryDTO({
    required this.totalVehicleBoxTypes,
    required this.totalCapacity,
    required this.totalLoad,
    required this.totalFillPercentage,
    required this.totalLoadPercentageExact,
    required this.volume,
  });

  factory VehicleBoxTypesSummaryDTO.fromJson(Map<String, dynamic> json) {
    return VehicleBoxTypesSummaryDTO(
      totalVehicleBoxTypes: json['total_vehicle_box_types'] as int,
      totalCapacity: (json['total_capacity'] as num).toDouble(),
      totalLoad: (json['total_load'] as num).toDouble(),
      totalFillPercentage: json['total_fill_percentage'] as int,
      totalLoadPercentageExact: (json['total_load_percentage_exact'] as num).toDouble(),
      volume: json['volume'] as Map<String, dynamic>,
    );
  }
}

class OrderSummaryVoucherDTO {
  final int id;
  final String code;
  final String discountType;
  final String discountValue;

  OrderSummaryVoucherDTO({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
  });

  factory OrderSummaryVoucherDTO.fromJson(Map<String, dynamic> json) {
    return OrderSummaryVoucherDTO(
      id: json['id'] as int,
      code: json['code'] as String,
      discountType: json['discount_type'] as String,
      discountValue: json['discount_value'] as String,
    );
  }
}
