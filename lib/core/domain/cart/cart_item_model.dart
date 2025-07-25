import 'package:gazzer/features/stores/domain/generic_item_entity.dart.dart';

class CartItemModel {
  final int quantity;
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final double? priceBeforeDiscount;
  final double rate;
  double get totalPrice => price * quantity;
  CartItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rate,
    required this.image,
    this.priceBeforeDiscount,

    this.quantity = 1,
  });

  CartItemModel.fromProduct(GenericItemEntity product, {this.quantity = 1})
    : id = product.id,
      name = product.name,
      description = product.description,
      price = product.price,
      rate = product.rate,
      image = product.image,
      priceBeforeDiscount = product.priceBeforeDiscount;
}
