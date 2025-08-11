import 'package:equatable/equatable.dart';

class CartableEntity extends Equatable {
  final int id;
  final String name;
  final double price;
  final String image;
  final double? priceBeforeDiscount;

  const CartableEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.priceBeforeDiscount,
  });

  @override
  List<Object?> get props => [id, name, price, priceBeforeDiscount, image];
}
