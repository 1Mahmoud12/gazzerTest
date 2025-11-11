import 'package:equatable/equatable.dart';

class CartSummaryModel extends Equatable {
  final double subTotal;
  final double deliveryFee;
  final double serviceFee;
  final double discount;
  final double total;
  final double tax;
  final double deliveryFeeDiscount;

  const CartSummaryModel({
    required this.subTotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.discount,
    required this.total,
    required this.tax,
    required this.deliveryFeeDiscount,
  });

  @override
  List<Object?> get props => [subTotal, deliveryFee, serviceFee, discount, total, tax, deliveryFeeDiscount];
}
