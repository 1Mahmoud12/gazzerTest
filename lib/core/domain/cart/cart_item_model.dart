import 'package:gazzer/core/domain/product/product_model.dart';

class CartItemModel extends ProductModel {
  final int quantity;
  double get totalPrice => price * quantity;
  CartItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.rate,
    required super.image,
    this.quantity = 1,
  });

  CartItemModel.fromProduct(ProductModel product, {this.quantity = 1})
    : super(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        rate: product.rate,
        image: product.image,
      );
}
