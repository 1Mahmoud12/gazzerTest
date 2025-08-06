import 'package:equatable/equatable.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

enum CartItemType { plate, product }

class CartItemEntity extends Equatable {
  final int id;
  final int prodId;
  final CartItemType type;
  final String name;
  final double price;
  final double? priceBeforeDiscount;

  final List<CartItemOption> options;
  final int quantity;
  final String? notes;

  double get totalPrice => price * quantity; // TODO: calculation
  // double get _basePRice => options.any((e)=>e.)
  const CartItemEntity({
    required this.id,
    required this.prodId,
    required this.type,
    required this.name,
    required this.price,
    required this.quantity,
    required this.priceBeforeDiscount,
    this.notes,
    this.options = const [],
  });

  static CartItemEntity fromProduct(GenericItemEntity prod) {
    return CartItemEntity(
      id: 0,
      prodId: prod.id,
      type: CartItemType.product,
      name: prod.name,
      price: prod.price,
      quantity: 1, // Default quantity
      priceBeforeDiscount: prod.priceBeforeDiscount,
    );
  }

  CartItemEntity copyWith({
    int? id,
    int? prodId,
    CartItemType? type,
    String? name,
    double? price,
    int? quantity,
    double? priceBeforeDiscount,
    String? notes,
    List<CartItemOption>? options,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      prodId: prodId ?? this.prodId,
      type: type ?? this.type,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      priceBeforeDiscount: priceBeforeDiscount ?? this.priceBeforeDiscount,
      notes: notes ?? this.notes,
      options: options ?? List.from(this.options), // Create a new list to ensure state change detection
    );
  }

  @override
  List<Object?> get props => [id, prodId, type, name, price, quantity, priceBeforeDiscount, notes, options];
}

class CartItemOption extends Equatable {
  final int id;
  final String name;
  final List<CartOptionValue> values;

  const CartItemOption({
    required this.id,
    required this.name,
    required this.values,
  });

  CartItemOption.fromOption(ItemOptionEntity option, List<CartOptionValue> vals) : id = option.id, name = option.name, values = vals;

  @override
  List<Object?> get props => [id, name, values];
}

class CartOptionValue extends Equatable {
  final int id;
  final String name;
  final double price;

  const CartOptionValue({
    required this.id,
    required this.name,
    required this.price,
  });

  CartOptionValue.fromOptionValue(OpionValueEntity value) : id = value.id, name = value.name, price = value.price;

  @override
  List<Object?> get props => throw UnimplementedError();
}
