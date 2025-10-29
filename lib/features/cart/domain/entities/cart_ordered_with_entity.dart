import 'package:equatable/equatable.dart';

class CartOrderedWithEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final int? quantityInStock;
  final double rate;
  final int reviewCount;
  final String relatedTo;

  const CartOrderedWithEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    this.quantityInStock,
    required this.rate,
    required this.reviewCount,
    required this.relatedTo,
  });

  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    price,
    quantity,
    quantityInStock,
    rate,
    reviewCount,
    relatedTo,
  ];
}
