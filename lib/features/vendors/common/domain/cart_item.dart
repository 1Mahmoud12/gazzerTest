import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

enum CartItemType { plate, product }

class CartItem {
  late final int id;
  late final int prodId;
  late final CartItemType type;
  late final String name;
  late final double price;
  late final double? priceBeforeDiscount;

  final List<CartItemOption> options = [];
  late int quantity;
  String? notes;

  double get totalPrice => price * quantity; // TODO: calculation
  // double get _basePRice => options.any((e)=>e.)
  CartItem({
    required this.id,
    required this.prodId,
    required this.type,
    required this.name,
    required this.price,
    required this.quantity,
    required this.priceBeforeDiscount,
  });

  CartItem.fromProduct(GenericItemEntity prod) {
    id = 0;
    prodId = prod.id;
    type = CartItemType.product;
    name = prod.name;
    price = prod.price;
    quantity = 1; // Default quantity
    priceBeforeDiscount = prod.priceBeforeDiscount;
  }
}

class CartItemOption {
  final int id;
  final String name;
  final List<CartOptionValue> values;

  CartItemOption({
    required this.id,
    required this.name,
    required this.values,
  });

  CartItemOption.fromOption(ItemOptionEntity option, List<CartOptionValue> vals) : id = option.id, name = option.name, values = vals;
}

class CartOptionValue {
  final int id;
  final String name;
  final double price;

  CartOptionValue({
    required this.id,
    required this.name,
    required this.price,
  });

  CartOptionValue.fromOptionValue(OpionValueEntity value) : id = value.id, name = value.name, price = value.price;
}
