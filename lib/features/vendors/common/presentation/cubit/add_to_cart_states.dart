import 'package:equatable/equatable.dart';
import 'package:gazzer/features/vendors/common/domain/cart_item.dart';

class AddToCartStates extends Equatable {
  final int qntity;
  final String? note;
  final double totalPrice;
  final List<CartItemOption> options;

  const AddToCartStates({
    required this.qntity,
    required this.note,
    required this.totalPrice,
    required this.options,
  });

  AddToCartStates copyWith({
    int? qntity,
    String? note,
    double? totalPrice,
    List<CartItemOption>? options,
  }) {
    return AddToCartStates(
      qntity: qntity ?? this.qntity,
      note: note ?? this.note,
      totalPrice: totalPrice ?? this.totalPrice,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [
    qntity,
    note,
    totalPrice,
    options,
  ];
}
