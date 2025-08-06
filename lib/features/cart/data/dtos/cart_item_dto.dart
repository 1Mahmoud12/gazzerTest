import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';

class CartItemDTO {
  int? id;
  String? cartableType;
  GenericItemDTO? cartable;
  int? quantity;
  List<CartOptionDTO>? optionValues;
  String? notes;

  CartItemDTO.fromJson(Map<String, dynamic> json, bool isPlate) {
    id = json['id'];
    cartableType = json['cartable_type'];
    quantity = json['quantity'];
    if (json['option_values'] != null) {
      optionValues = <CartOptionDTO>[];
      json['option_values'].forEach((v) {
        optionValues!.add(CartOptionDTO.fromJson(v));
      });
    }
    notes = json['notes'];
    if (json['cartable'] != null) {
      if (isPlate) {
        cartable = PlateDTO.fromJson(json['cartable']);
      } else {
        cartable = ProductDTO.fromJson(json['cartable']);
      }
    }
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id ?? 0,
      type: cartableType == 'Plate' ? CartItemType.plate : CartItemType.product,
      prod: cartable!.toCartable(),
      quantity: quantity ?? 1,
      options: optionValues?.map((option) => option.toEntity()).toList() ?? [],
      notes: notes,
    );
  }
}

class CartOptionDTO {
  int? optionId;
  String? optionName;
  List<CartOptionValueDTO>? values;

  CartOptionDTO.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionName = json['option_name'];
    if (json['values'] != null) {
      values = <CartOptionValueDTO>[];
      json['values'].forEach((v) {
        values!.add(CartOptionValueDTO.fromJson(v));
      });
    }
  }
  CartOptionEntity toEntity() {
    return CartOptionEntity(
      id: optionId ?? 0,
      name: optionName ?? '',
      values: values?.map((value) => value.toEntity()).toList() ?? [],
    );
  }
}

class CartOptionValueDTO {
  int? valueId;
  String? valueName;
  double? price;

  CartOptionValueDTO.fromJson(Map<String, dynamic> json) {
    valueId = json['value_id'];
    valueName = json['value_name'];
    price = double.tryParse(json['value_price'].toString());
  }
  CartOptionValueEntity toEntity() {
    return CartOptionValueEntity(
      id: valueId ?? 0,
      name: valueName ?? '',
      price: price ?? 0.0,
    );
  }
}

extension GenericItemDTOExtension on GenericItemDTO {
  CartableEntity toCartable() {
    return CartableEntity(
      id: id ?? 0,
      name: name ?? '',
      image: image ?? '',
      price: price ?? 0.0,
      priceBeforeDiscount: appPrice,
    );
  }
}
