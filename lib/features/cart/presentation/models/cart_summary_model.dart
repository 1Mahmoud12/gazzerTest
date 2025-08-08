import 'package:equatable/equatable.dart';

class CartSummaryModel extends Equatable {
  final double subTotal;
  final double deliveryFee;
  final double serviceFee;
  final double discount;
  final double total;

  const CartSummaryModel({
    required this.subTotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.discount,
    required this.total,
  });

  @override
  List<Object?> get props => [subTotal, deliveryFee, serviceFee, discount, total];
}
