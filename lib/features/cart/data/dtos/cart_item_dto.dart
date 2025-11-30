import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cart_option_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cart_ordered_with_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cartable_entity.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_dto.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_dto.dart';

class CartItemDTO {
  int? id;
  String? cartableType;
  GenericItemDTO? cartable;
  int? quantity;
  num? itemPrice;
  num? totalPrice;
  int? quantityInStock;
  List<CartOptionDTO>? optionValues;
  List<CartOrderedWithDTO>? orderedWith;
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
    if (json['ordered_with'] != null) {
      orderedWith = <CartOrderedWithDTO>[];
      json['ordered_with'].forEach((v) {
        orderedWith!.add(CartOrderedWithDTO.fromJson(v));
      });
    }
    notes = json['notes'];
    itemPrice = json['item_price'];
    totalPrice = json['total_price'];
    if (json['cartable'] != null) {
      quantityInStock = json['cartable']['quantity_in_stock'];
      if (isPlate) {
        cartable = PlateDTO.fromJson(json['cartable']);
      } else {
        cartable = ProductDTO.fromJson(json['cartable']);
      }
    }
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      cartId: id ?? 0,
      type: CartItemType.fromString(cartableType?.toLowerCase() ?? ''),
      prod: cartable!.toCartable(),
      quantity: quantity ?? 1,
      quantityInStock: quantityInStock,
      options: optionValues?.map((option) => option.toEntity()).toList() ?? [],
      orderedWith: orderedWith?.map((ow) => ow.toEntity()).toList() ?? [],
      notes: notes,
      itemPrice: itemPrice ?? 0,
      totalPrice: totalPrice ?? 0,
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
      id: "${optionId ?? 0}",
      name: optionName ?? '',
      values: values?.map((value) => value.toEntity()).toList() ?? [],
    );
  }
}

class CartOptionValueDTO {
  String? valueId;
  String? valueName;
  double? price;

  CartOptionValueDTO.fromJson(Map<String, dynamic> json) {
    valueId = json['value_id'];
    valueName = json['value_name'];
    price = double.tryParse(json['value_price'].toString());
  }
  CartOptionValueEntity toEntity() {
    return CartOptionValueEntity(
      id: valueId ?? '0',
      name: valueName ?? '',
      price: price ?? 0.0,
    );
  }
}

class CartOrderedWithDTO {
  int? id;
  String? name;
  String? image;
  String? price;
  int? quantityInStock;
  double? rate;
  int? reviewCount;
  String? relatedTo;
  int? quantity;

  CartOrderedWithDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price']?.toString();
    quantityInStock = json['quantity_in_stock'];
    rate = double.tryParse(json['rate']?.toString() ?? '0');
    reviewCount = json['reviewCount'];
    relatedTo = json['related_to'];
    quantity = json['quantity'];
  }

  CartOrderedWithEntity toEntity() {
    return CartOrderedWithEntity(
      id: id ?? 0,
      name: name ?? '',
      image: image ?? '',
      price: double.tryParse(price ?? '0') ?? 0.0,
      quantity: quantity ?? 1,
      quantityInStock: quantityInStock,
      rate: rate ?? 0.0,
      reviewCount: reviewCount ?? 0,
      relatedTo: relatedTo ?? '',
    );
  }
}

extension GenericItemDTOExtension on GenericItemDTO {
  CartableEntity toCartable() {
    // Convert to entity first to get the price with offer applied
    final entity = toEntity();
    return CartableEntity(
      id: id ?? 0,
      name: name ?? '',
      image: image ?? '',
      price: entity.price,
      // This already accounts for offer discount
      priceBeforeDiscount: entity.priceBeforeDiscount,
    );
  }
}
